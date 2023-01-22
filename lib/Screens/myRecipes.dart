import 'package:co_chef_mobile/Bloc/RecipeBloc/recipe_bloc.dart';
import 'package:co_chef_mobile/Models/Recipe.dart';
import 'package:co_chef_mobile/Widgets/RecipeCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:progress_indicators/progress_indicators.dart';

class MyRecipes extends StatefulWidget {
  const MyRecipes({Key? key, this.isFavorite = false}) : super(key: key);
  static String route = "/myRecipes";
  final bool isFavorite;
  @override
  _MyRecipesState createState() => _MyRecipesState();
}

class _MyRecipesState extends State<MyRecipes> {
  List<Recipe> recipes = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RecipeBloc()..add(widget.isFavorite ? RecipeGetFavortieRecipes() : RecipeGetPersonalRecipes()),
      child: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state is RecipeLoading) {
            return Scaffold(
              body: Center(
                child: ScalingText(
                  'Co-Chef',
                  style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
                ),
              ),
            );
          } else if (state is RecipeNoInternet) {
            Scaffold(
              body: Center(
                child: Text('لا يوجد اتصال بالانترنت'),
              ),
            );
          } else if (state is RecipeFetchingDone) {
            print(state.recipes);
            print('gessrsersr');
            recipes = state.recipes!;
            return Scaffold(
              backgroundColor: Colors.white,
              body: RefreshIndicator(
                color: AppColors.color2,
                onRefresh: () async {
                  BlocProvider.of<RecipeBloc>(context)
                      .add(widget.isFavorite ? RecipeGetFavortieRecipes() : RecipeGetPersonalRecipes());
                },
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 55.0),
                  scrollDirection: Axis.vertical,
                  itemCount: recipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        (widget.isFavorite)
                            ? Container()
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Center(
                                    child: Column(
                                  children: [
                                    Text(
                                      translate(recipes[index].state!),
                                      overflow: TextOverflow.ellipsis,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Icon(
                                      chooseIcon(recipes[index].state!),
                                      size: 30.0,
                                    )
                                  ],
                                ))),
                        Container(
                          width: (widget.isFavorite)
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width * 0.75,
                          child: RecipeCard(
                            recipe: recipes[index],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // floatingActionButton: Padding(
              //   padding: EdgeInsets.only(bottom: 50),
              //   child: FloatingActionButton(
              //     backgroundColor: AppColors.color2,
              //     child: Icon(
              //       Icons.add,
              //       color: AppColors.color4,
              //     ),
              //     onPressed: () {
              //       Navigator.pushNamed(context, AddRecipeScreen.route);
              //     },
              //   ),
              // ),
            );
          }
          return Text('data');
        },
      ),
    );
  }
}

String translate(String state) {
  if (state == 'pending')
    return 'بالانتظار';
  else if (state == 'accepted')
    return 'مقبولة';
  else if (state == 'rejected')
    return 'مرفوضة';
  else
    return ' ';
}

IconData chooseIcon(String state) {
  if (state == 'pending')
    return Icons.timer;
  else if (state == 'accepted')
    return Icons.check;
  else if (state == 'rejected')
    return Icons.close;
  else
    return Icons.error;
}

import 'package:co_chef_mobile/Bloc/RecipeBloc/recipe_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Models/Recipe.dart';
import 'package:co_chef_mobile/Screens/AddRecipeScreen.dart';
import 'package:co_chef_mobile/Widgets/RecipeCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:progress_indicators/progress_indicators.dart';

class Screen1 extends StatefulWidget {
  Screen1({Key? key}) : super(key: key);

  static String route = "/page1";
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> with AutomaticKeepAliveClientMixin {
  List<Recipe> recipes = [];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => RecipeBloc()..add(RecipeGettAll()),
      child: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state is RecipeLoading || state is RecipeInitial) {
            return Scaffold(
              backgroundColor: AppColors.color4,
              body: Center(
                  child: ScalingText('Co-Chef',
                      style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'))),
            );
          } else if (state is RecipeNoInternet) {
            Scaffold(body: Center(child: Text('لا يوجد اتصال بالانترنت')));
          } else if (state is RecipeFetchingDone) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: RefreshIndicator(
                color: AppColors.color2,
                onRefresh: () async {
                  BlocProvider.of<RecipeBloc>(context).add(RecipeGettAll());
                },
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 55.0),
                  scrollDirection: Axis.vertical,
                  itemCount: state.data!.recipes!.recipes!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RecipeCard(recipe: state.data!.recipes!.recipes![index]);
                  },
                ),
              ),
              floatingActionButton: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: FloatingActionButton(
                  backgroundColor: color2,
                  child: Icon(
                    Icons.add,
                    color: color4,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AddRecipeScreen.route);
                  },
                ),
              ),
            );
          }
          return Center(child: Text('Loading...'));
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

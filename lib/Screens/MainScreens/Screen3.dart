import 'package:co_chef_mobile/Bloc/IngredientsBloc/ingredients_bloc.dart';
import 'package:co_chef_mobile/Models/ingredientsCategory.dart';
import 'package:co_chef_mobile/Screens/IngredientsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:progress_indicators/progress_indicators.dart';

class Screen3 extends StatefulWidget {
  Screen3({Key? key}) : super(key: key);

  static String route = "/page3";

  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  List<IngredientCategory> categories = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IngredientsBloc()..add(IngredientsGetCategories()),
      child: BlocBuilder<IngredientsBloc, IngredientsState>(
        builder: (context, state) {
          if (state is IngredientsLoading) {
            return Scaffold(
              body: Center(
                child: ScalingText(
                  'Co-Chef',
                  style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
                ),
              ),
            );
          } else if (state is IngredientsNoInternet) {
            Scaffold(
              body: Center(
                child: Text('لا يوجد اتصال بالانترنت'),
              ),
            );
          } else if (state is IngredientsFetchingDone) {
            categories = state.dataList!;
            return Scaffold(
              backgroundColor: Colors.white,
              body: RefreshIndicator(
                color: AppColors.color2,
                onRefresh: () async {
                  BlocProvider.of<IngredientsBloc>(context).add(IngredientsGetCategories());
                },
                child: GridView.builder(
                    padding: EdgeInsets.only(bottom: 55.0),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200, childAspectRatio: 3 / 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
                    itemCount: categories.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IngredientsScreen(
                                  id: categories[index].id,
                                ),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              categories[index].name,
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            decoration: BoxDecoration(color: AppColors.color2, borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      );
                      // return StoreItem(
                      //     route: '/IngredientsScreen',
                      //     text: categories[index].name);
                    }),
              ),
            );
          }
          return Text('data');
        },
      ),
    );
  }
}

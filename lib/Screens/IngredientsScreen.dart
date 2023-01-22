import 'package:co_chef_mobile/Bloc/IngredientsBloc/ingredients_bloc.dart';
import 'package:co_chef_mobile/Models/Ingredient.dart';
import 'package:co_chef_mobile/Widgets/storeDesignWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

class IngredientsScreen extends StatefulWidget {
  final int id;
  IngredientsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _IngredientsScreenState createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  List<IngredientShop> ingredeints = [];
  @override
  Widget build(BuildContext context) {
    // IngredientsBloc ingredientsBloc = BlocProvider.of<IngredientsBloc>(context);
    return BlocProvider(
      create: (context) => IngredientsBloc()..add(IngredientsGetDetails(widget.id)),
      child: BlocBuilder<IngredientsBloc, IngredientsState>(
        // bloc: ingredientsBloc..add(IngredientsGetDetails(widget.id)),
        builder: (context, state) {
          print('object');
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
            ingredeints = state.ingredientShop!;
            return Scaffold(
              backgroundColor: Colors.white,
              body: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 2 / 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
                itemCount: ingredeints.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (ctx, i) {
                  return StoreDesignWidget(ingredient: ingredeints[i]);
                },
              ),
            );
          }
          return Text('data');
        },
      ),
    );
  }
}

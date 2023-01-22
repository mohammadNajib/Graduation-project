import 'package:co_chef_mobile/Bloc/IngredientsBloc/ingredients_bloc.dart';
import 'package:co_chef_mobile/Models/Ingredient.dart';
import 'package:co_chef_mobile/Widgets/IngredientSelectCard.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';

class IngredientsDialog extends StatefulWidget {
  final List<IngredientShop> ingredeintsList;
  IngredientsDialog({Key? key, required this.ingredeintsList}) : super(key: key);

  @override
  _IngredientsDialogState createState() => _IngredientsDialogState();
}

class _IngredientsDialogState extends State<IngredientsDialog> {
  @override
  Widget build(BuildContext context) {
    List<IngredientShop> ingredeints = [];
    return BlocProvider(
        create: (context) => IngredientsBloc()..add(IngredientsGetAll()),
        child: BlocBuilder<IngredientsBloc, IngredientsState>(builder: (context, state) {
          if (state is IngredientsLoading) {
            return Scaffold(
              appBar: AppBar(backgroundColor: AppColors.color2, title: Text('أختر المكونات المطلوبة')),
              body: Center(child: CircularProgressIndicator(color: AppColors.color4)),
            );
          } else if (state is IngredientsFetchingDone) {
            ingredeints = state.ingredientShop!;
            return Scaffold(
                appBar: AppBar(backgroundColor: AppColors.color2, title: Text('أختر المكونات المطلوبة')),
                body: ListView.builder(
                  itemCount: ingredeints.length,
                  itemBuilder: (BuildContext context, int index) {
                    return IngredientSelectCard(ingredient: ingredeints[index], ingredientList: widget.ingredeintsList);
                  },
                ));
          }
          return Scaffold(body: Center(child: Text('Error')));
        }));
  }
}

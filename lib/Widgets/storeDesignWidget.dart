import 'package:co_chef_mobile/Bloc/Cartbloc/cart_bloc.dart';
import 'package:co_chef_mobile/Models/CartItem.dart';
import 'package:co_chef_mobile/Models/Ingredient.dart';
import 'package:co_chef_mobile/Models/IngredientDetails.dart';
import 'package:co_chef_mobile/Repositories/IngredientsRepo.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as Appcolors;
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreDesignWidget extends StatefulWidget {
  final IngredientShop ingredient;

  StoreDesignWidget({required this.ingredient});

  @override
  _StoreDesignWidgetState createState() => _StoreDesignWidgetState();
}

class _StoreDesignWidgetState extends State<StoreDesignWidget> {
  IngredientRepo ingredientRepo = IngredientRepo();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        IngredientDetails ingredientDetails = await ingredientRepo.showIngredientDetails(widget.ingredient.id!);
        showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
            context: context,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: 80.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                            color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1.0)),
                          child: Image.network(widget.ingredient.image!)),
                    ),
                    Text(widget.ingredient.name!, style: TextStyle(fontSize: 25.0)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.run_circle_outlined),
                            Text(widget.ingredient.calories.toString(), style: TextStyle(fontSize: 25.0)),
                            Text('السعرات', style: TextStyle(fontSize: 25.0)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.monetization_on_outlined),
                            Text(widget.ingredient.price.toString(), style: TextStyle(fontSize: 25.0)),
                            Text('السعر', style: TextStyle(fontSize: 25.0)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(CartAddItem(CartItem(
                                id: widget.ingredient.id!,
                                name: widget.ingredient.name!,
                                image: widget.ingredient.image!,
                                amount: widget.ingredient.amount!,
                                calories: widget.ingredient.calories!,
                                category: widget.ingredient.category!,
                                price: widget.ingredient.price!,
                                unit: widget.ingredient.unit!,
                                orderAmount: 1)));
                            Navigator.pop(context);
                          },
                          child: Text('إضافة الى السلة'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolors.color3,
                            elevation: 3.0,
                            textStyle: TextStyle(fontSize: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: ingredientDetails.recommended!.recommendedIng!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return RecIngredientWidget(
                                      ingredient: ingredientDetails.recommended!.recommendedIng![index]);
                                })),
                      ],
                    )
                  ],
                ),
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Appcolors.color4, offset: const Offset(5.0, 5.0), blurRadius: 15.0, spreadRadius: 0.0), //BoxShadow
        ]),
        // color: kHomeScreenAppBar,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: GridTile(
            child: Container(color: Colors.white, child: Image.network(widget.ingredient.image!, fit: BoxFit.cover)),
            footer: GridTileBar(
              backgroundColor: Colors.black38,
              title: Text(widget.ingredient.name!,
                  style: TextStyle(fontFamily: 'subTitleArabic', color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }
}

class RecIngredientWidget extends StatelessWidget {
  const RecIngredientWidget({Key? key, required this.ingredient}) : super(key: key);

  final IngredientShop ingredient;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.2,
        padding: EdgeInsets.all(10.0),
        child: StoreDesignWidget(ingredient: ingredient));
  }
}

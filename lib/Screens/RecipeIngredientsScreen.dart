import 'package:co_chef_mobile/Bloc/Cartbloc/cart_bloc.dart';
import 'package:co_chef_mobile/Models/CartItem.dart';
import 'package:co_chef_mobile/Models/RecipesResponse.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RecipeIngredientsScreen extends StatefulWidget {
  const RecipeIngredientsScreen({Key? key, required this.ingredients}) : super(key: key);
  final List<Ingredient> ingredients;

  @override
  _RecipeIngredientsScreenState createState() => _RecipeIngredientsScreenState();
}

class _RecipeIngredientsScreenState extends State<RecipeIngredientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.color2,
        title: Text('المكونات'),
      ),
      backgroundColor: AppColors.color4,
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        // controller: scrollController,
        shrinkWrap: true,
        itemCount: widget.ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Container(
              height: 100,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.color4,
                border: Border.all(
                  color: AppColors.color2,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(widget.ingredients[index].image!), fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          Text(
                            widget.ingredients[index].name!,
                            style: TextStyle(
                              fontSize: 30,
                              color: AppColors.color3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                (widget.ingredients[index].pivot!.quantity * widget.ingredients[index].amount!.value)
                                        .toString() +
                                    ' ' +
                                    widget.ingredients[index].amount!.unit!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: AppColors.color3,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<CartBloc>(context).add(
                          CartAddItem(CartItem(
                              id: widget.ingredients[index].id!,
                              name: widget.ingredients[index].name!,
                              image: widget.ingredients[index].image!,
                              price: widget.ingredients[index].price!,
                              calories: widget.ingredients[index].calories!,
                              amount: widget.ingredients[index].amount!.value!,
                              unit: widget.ingredients[index].amount!.unit!,
                              orderAmount: widget.ingredients[index].pivot!.quantity,
                              category: '')),
                        );
                        Fluttertoast.showToast(
                            msg: 'تمت إضافة المكون للسلة',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      child: Icon(Icons.add, color: AppColors.color2, size: 50.0),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.0001)
                ],
              ),
            ),
          );
        },
        // children: Ingredient.ingredientList(),
      ),
    );
  }
}

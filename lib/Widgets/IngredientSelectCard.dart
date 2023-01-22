import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Models/Ingredient.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

// ignore: must_be_immutable
class IngredientSelectCard extends StatefulWidget {
  IngredientSelectCard({Key? key, required this.ingredient, required this.ingredientList}) : super(key: key);
  IngredientShop ingredient;
  final List<IngredientShop> ingredientList;

  @override
  _IngredientSelectCardState createState() => _IngredientSelectCardState();
}

class _IngredientSelectCardState extends State<IngredientSelectCard> {
  bool checked = false;
  // int ammount = 0;
  @override
  void initState() {
    for (var item in widget.ingredientList) {
      if (item.id == widget.ingredient.id) {
        widget.ingredient = item;
        // widget.ingredient.orderAmmount = item.orderAmmount;

        // widget.ingredient.amount = item.amount;
        checked = true;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.ingredient.image!),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      widget.ingredient.name!,
                      style: TextStyle(
                        fontSize: 30,
                        color: color3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        actionButton(() {
                          setState(() {
                            if (widget.ingredient.orderAmount != 0) widget.ingredient.orderAmount--;
                          });
                        }, Icons.remove),
                        Text(
                          ((widget.ingredient.amount! * widget.ingredient.orderAmount).toString() +
                              ' ' +
                              widget.ingredient.unit!),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: color3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actionButton(() {
                          setState(() {
                            widget.ingredient.orderAmount++;
                          });
                        }, Icons.add),
                      ],
                    )
                  ],
                ),
                Switch(
                    value: checked,
                    activeColor: AppColors.color2,
                    onChanged: (value) {
                      setState(() {
                        checked = value;
                        if (value == true) {
                          widget.ingredientList.add(widget.ingredient);
                        } else {
                          widget.ingredientList.remove(widget.ingredient);
                        }
                      });
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget actionButton(Function function, IconData icon) {
    return Container(
      height: 30,
      child: FloatingActionButton(
        backgroundColor: AppColors.color2,
        onPressed: () => function,
        child: Icon(icon, color: AppColors.color4),
      ),
    );
  }
}

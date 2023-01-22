import 'package:co_chef_mobile/Bloc/Cartbloc/cart_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Models/CartItem.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';

class IngredientCartCard extends StatefulWidget {
  final CartItem item;

  IngredientCartCard({Key? key, required this.item}) : super(key: key);

  @override
  _IngredientCartCardState createState() => _IngredientCartCardState();
}

class _IngredientCartCardState extends State<IngredientCartCard> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 100,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.color4,
          border: Border.all(color: AppColors.color2, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(widget.item.image), fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(widget.item.name, style: TextStyle(fontSize: 30, color: color3, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        actionButton(() {
                          setState(() {
                            if (widget.item.orderAmount != 0) {
                              widget.item.orderAmount--;
                              BlocProvider.of<CartBloc>(context).add(CartDecreaseAmmount(widget.item.id));
                            }
                          });
                        }, Icons.remove),
                        Text(
                          ((widget.item.orderAmount * widget.item.amount).toString() + ' ' + widget.item.unit),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25, color: color3, fontWeight: FontWeight.bold),
                        ),
                        actionButton(() {
                          setState(() {
                            widget.item.orderAmount++;
                            BlocProvider.of<CartBloc>(context).add(CartIncreaseAmmount(widget.item.id));
                          });
                        }, Icons.add),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () => BlocProvider.of<CartBloc>(context).add(CartRemoveItem(widget.item.id)),
                  child: Icon(Icons.delete, color: AppColors.color2, size: 35.0),
                )
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
          backgroundColor: AppColors.color2, onPressed: () => function(), child: Icon(icon, color: AppColors.color4)),
    );
  }
}

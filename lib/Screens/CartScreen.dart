import 'package:co_chef_mobile/Bloc/Cartbloc/cart_bloc.dart';
import 'package:co_chef_mobile/Widgets/Ingredient.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AddressChoseScreen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  static String route = "/IngredientsScreen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return BlocBuilder<CartBloc, CartState>(
      bloc: BlocProvider.of<CartBloc>(context),
      builder: (context, state) {
        if (state is CartIsEmpty)
          return Scaffold(
            body: Center(
              child: Image.asset('images/empty-cart.png'),
            ),
          );
        else if (state is CartList)
          return Scaffold(
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: FloatingActionButton(
                backgroundColor: AppColors.color2,
                child: Center(child: Text('أطلب  ')),
                onPressed: () {
                  showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
                        return ChooseAddrssScreen();
                      });
                },
              ),
            ),
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: AppColors.color4,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.gross.toString(), style: TextStyle(fontSize: 35.0)),
                  Text(' : المجموع', style: TextStyle(fontSize: 35.0))
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: state.cart.length,
                      itemBuilder: (BuildContext context, int index) {
                        return IngredientCartCard(item: state.cart[index]);
                      },
                    ),
                  ),
                  // Expanded(child: Text('data'))
                ],
              ),
            ),
          );

        return Scaffold(body: Center(child: Image.asset('images/empty-cart.png')));
      },
    );
  }
}

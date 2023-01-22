import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:flutter/material.dart';

class IngredientsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }

  static void orderIngredients(BuildContext context, String ingredients) {
    ScrollController scrollController = ScrollController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: color4,
          // title: TextListItem(text: 'قائمة المكونات'),
          title: Text(
            'قائمة المكونات',
            textAlign: TextAlign.center,
            style: appTextStyle,
          ),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 300,
                height: 300,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  controller: scrollController,
                  children: [
                    Text(
                      ingredients,
                      style: appTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            new ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('إغلاق', textAlign: TextAlign.center, style: appTextStyle)),
          ],
        );
      },
    );
  }
}

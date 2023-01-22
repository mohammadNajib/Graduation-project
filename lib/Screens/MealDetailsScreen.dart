import 'package:co_chef_mobile/Bloc/MealBloc/meal_bloc.dart';
import 'package:co_chef_mobile/Models/MealOrder.dart';
import 'package:co_chef_mobile/Screens/userProfile.dart';
import 'package:co_chef_mobile/Widgets/TextListItem.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_star_rating/simple_star_rating.dart';

import 'AddressChoseScreen.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({Key? key, required this.meal}) : super(key: key);
  final Meal meal;

  @override
  _MealDetailsScreenState createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  GlobalKey itemKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color4,
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
                  return ChooseAddrssScreen(
                    meal: widget.meal,
                  );
                });
          },
        ),
      ),
      body: ListView(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        children: [
          Image(image: NetworkImage(widget.meal.image!)),
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(widget.meal.rating.toString(), style: TextStyle(color: AppColors.color3, fontSize: 30.0)),
                    Icon(Icons.star, color: AppColors.color2, size: 43),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(widget.meal.name!, style: TextStyle(fontSize: 40.0, color: AppColors.color3)),
                ),
              ),
            ],
          ),
          Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 17),
                  TextListItem(text: widget.meal.price.toString()),
                  SizedBox(height: 17),
                  TextListItem(text: Duration(milliseconds: widget.meal.preparationTime!).inMinutes.toString()),
                  SizedBox(height: 17),
                  TextListItem(text: widget.meal.category!),
                  SizedBox(height: 17),
                  TextListItem(text: widget.meal.chef!.user!.name!)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextListItem(
                    text: 'السعر',
                  ),
                  TextListItem(
                    text: 'المدة بالدقائق',
                  ),
                  TextListItem(
                    text: 'الصنف',
                  ),
                  GestureDetector(
                      child: TextListItem(
                        text: 'الناشر',
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => UserProfile(id: widget.meal.chef!.user!.id!)));
                      }),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.attach_money,
                    size: 43,
                    color: AppColors.color2,
                  ),
                  Icon(
                    Icons.access_alarm,
                    size: 43,
                    color: AppColors.color2,
                  ),
                  Icon(
                    Icons.category,
                    size: 43,
                    color: AppColors.color2,
                  ),
                  Icon(
                    Icons.person,
                    size: 43,
                    color: AppColors.color2,
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: SimpleStarRating(
              allowHalfRating: false,
              starCount: 5,
              rating: (widget.meal.myRating == null) ? 3 : widget.meal.myRating!.toDouble(),
              size: 32,
              onRated: (rate) async => BlocProvider.of<MealBloc>(context).add(MealAddRating(widget.meal.id!, rate)),
              isReadOnly: (widget.meal.myRating == null) ? false : true,
              spacing: 10,
            ),
          ),
          SizedBox(height: 60)
        ],
      ),
    );
  }
}

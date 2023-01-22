import 'package:co_chef_mobile/Screens/AddressScreen.dart';
import 'package:co_chef_mobile/Screens/OrderHistoryScreen.dart';
import 'package:co_chef_mobile/Screens/myRecipes.dart';
import 'package:co_chef_mobile/Widgets/ProfileButton.dart';
import 'package:flutter/material.dart';

class ProfileButtons extends StatelessWidget {
  final bool? isPersonal;
  const ProfileButtons({
    Key? key,
    this.isPersonal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ProfileButton(
                    icon: Icons.food_bank,
                    data: 'وصفاتي',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyRecipes()));
                    }),
                ProfileButton(
                    icon: Icons.location_on_outlined,
                    data: 'عناويني',
                    onTap: () {
                      Navigator.pushNamed(context, AddressScreen.route);
                    })
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ProfileButton(
                    icon: Icons.history,
                    data: 'سجل طلباتي',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderHistoryScreen(),
                          ));
                    }),
                ProfileButton(icon: Icons.add_business_outlined, data: 'اقترح مكون', onTap: () {})
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ProfileButton(
                    icon: Icons.favorite,
                    data: 'المفضلة',
                    onTap: () {
                      print('object');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyRecipes(
                              isFavorite: true,
                            ),
                          ));
                    }),
                ProfileButton(icon: Icons.star_border, data: 'تقييماتي', onTap: () {})
              ],
            ),
          )
        ],
      ),
    );
  }
}

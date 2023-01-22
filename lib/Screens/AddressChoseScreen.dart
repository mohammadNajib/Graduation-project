import 'package:co_chef_mobile/Bloc/AddressesBloc/addresses_bloc.dart';
import 'package:co_chef_mobile/Bloc/Cartbloc/cart_bloc.dart';
import 'package:co_chef_mobile/Bloc/MealBloc/meal_bloc.dart';
import 'package:co_chef_mobile/Models/Address/Address.dart';
import 'package:co_chef_mobile/Models/MealOrder.dart';
import 'package:co_chef_mobile/Repositories/AddressesRepo.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ChooseAddrssScreen extends StatefulWidget {
  const ChooseAddrssScreen({Key? key, this.meal}) : super(key: key);
  final Meal? meal;

  @override
  _ChooseAddrssScreenState createState() => _ChooseAddrssScreenState();
}

class _ChooseAddrssScreenState extends State<ChooseAddrssScreen> {
  @override
  Widget build(BuildContext context) {
    List<Address> addresses = [];
    return BlocProvider(
      create: (context) => AddressesBloc(AddressesRepo())..add(AddressesGetPersonalAddresses()),
      child: BlocBuilder<AddressesBloc, AddressesState>(
        builder: (context, state) {
          if (state is AddressesLoading)
            return Scaffold(
                body: Center(
                    child: ScalingText(
              'Co-Chef',
              style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
            )));
          else if (state is AddressesPersonalDone) {
            addresses = state.addresses;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.color2,
                title: Text('أختر العنوان المطلوب'),
              ),
              backgroundColor: AppColors.color4,
              body: Container(
                height: MediaQuery.of(context).size.height * 0.82,
                child: ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          print(' choosen address :  + ${addresses[index].id}');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35.0),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: MediaQuery.of(context).size.height * 0.4,
                                        margin: EdgeInsets.only(bottom: 50.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Container(
                                                width: 80.0,
                                                height: 8.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[400],
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                              ),
                                            ),
                                            Text(addresses[index].name!,
                                                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                                            Text(
                                              addresses[index].city! +
                                                  '-' +
                                                  addresses[index].area! +
                                                  '-' +
                                                  addresses[index].subarea!,
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                            Text(addresses[index].details ?? ' ', style: TextStyle(fontSize: 18.0)),
                                            Text('الطابق ${addresses[index].floor}'),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                                            ElevatedButton(
                                              onPressed: () {
                                                if (widget.meal != null) {
                                                  MealBloc mealBloc = MealBloc();
                                                  mealBloc.add(MealOrderMeal(widget.meal!, addresses[index].id!));
                                                } else {
                                                  BlocProvider.of<CartBloc>(context)
                                                      .add(CartOrderCart(addresses[index].id!));
                                                }
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: Text('إختيار العنوان', style: TextStyle(fontSize: 25.0)),
                                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.color3),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: 80,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.color4,
                                  border: Border.all(color: AppColors.color2, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(addresses[index].name!,
                                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                                    Text(addresses[index].city! + '-' + addresses[index].area!),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            );
          } else
            return Scaffold(
              body: Center(
                child: Text('حدث خطأ ما '),
              ),
            );
        },
      ),
    );
  }
}

import 'package:co_chef_mobile/Bloc/ChefsOrderBloc/chefsorders_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Repositories/ChefRepo.dart';
import 'package:co_chef_mobile/Screens/AddMealScreen.dart';
import 'package:co_chef_mobile/Widgets/PopUP.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

class ChefOrderScreen extends StatefulWidget {
  static String route = "/ChefOrderScreen";

  @override
  State<StatefulWidget> createState() => _ChefOrderScreenState();
}

class _ChefOrderScreenState extends State<ChefOrderScreen> {
  ChefsordersBloc chefsordersBloc = ChefsordersBloc();
  ChefRepo chefRepo = ChefRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chefsordersBloc.add(ChefsorderFetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChefsordersBloc, ChefsordersState>(
      bloc: chefsordersBloc,
      builder: (context, state) {
        if (state is ChefsorderDone)
          return Scaffold(
            appBar: AppBar(
              backgroundColor: color2,
              actions: [
                Switch(
                  value: chefRepo.isActive,
                  onChanged: (val) async {
                    if (val)
                      chefsordersBloc.add(ChefsorderToAvailable());
                    else
                      chefsordersBloc.add(ChefsorderToUnAvailable());
                  },
                  activeColor: color4,
                  inactiveTrackColor: color3,
                )
              ],
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: FloatingActionButton(
                backgroundColor: color2,
                child: Icon(
                  Icons.add,
                  color: color4,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AddMealScreen.route);
                },
              ),
            ),
            backgroundColor: color4,
            body: RefreshIndicator(
              color: AppColors.color2,
              onRefresh: () async {
                chefsordersBloc.add(ChefsorderFetch());
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.84,
                child: ListView.builder(
                  itemCount: chefRepo.orders.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return PopUp(
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: color4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              chefsordersBloc.add(ChefsorderAccept(chefRepo.orders[index].id!));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Center(
                                child: Text(
                                  'قبول',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: color2,
                                border: Border.all(
                                  color: color2,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              chefsordersBloc.add(ChefsorderReject(chefRepo.orders[index].id!));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Center(child: Text('رفض', style: TextStyle(color: Colors.white))),
                              decoration: BoxDecoration(
                                color: color2,
                                border: Border.all(color: color2, width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              ),
                            ),
                          ),
                          Text(chefRepo.orders[index].meal!.name!,
                              style: TextStyle(color: color2, fontSize: MediaQuery.of(context).size.width * .04)),
                          SizedBox(width: 1)
                        ],
                      ),
                      onTap: () {},
                    );
                  },
                ),
              ),
            ),
          );
        else if (state is ChefsorderLoading)
          return Scaffold(
            backgroundColor: AppColors.color4,
            appBar: AppBar(
              backgroundColor: color2,
              actions: [
                Switch(
                  value: chefRepo.isActive,
                  onChanged: (val) async {
                    if (val)
                      chefsordersBloc.add(ChefsorderToAvailable());
                    else
                      chefsordersBloc.add(ChefsorderToUnAvailable());
                  },
                  activeColor: color4,
                  inactiveTrackColor: color3,
                )
              ],
            ),
            body: Center(
              child: ScalingText(
                'Co-Chef',
                style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
              ),
            ),
          );
        else if (state is ChefordeUnavalibale)
          return Scaffold(
            backgroundColor: AppColors.color4,
            appBar: AppBar(
              backgroundColor: AppColors.color2,
              actions: [
                Switch(
                  value: chefRepo.isActive,
                  onChanged: (val) async {
                    if (val)
                      chefsordersBloc.add(ChefsorderToAvailable());
                    else
                      chefsordersBloc.add(ChefsorderToUnAvailable());
                  },
                  activeColor: color4,
                  inactiveTrackColor: color3,
                )
              ],
            ),
            body: Center(child: Text('غير متاح للطلبات', style: TextStyle(color: AppColors.color2, fontSize: 30.0))),
          );
        else
          return Scaffold(
            appBar: AppBar(
              backgroundColor: color2,
              actions: [
                Switch(
                  value: chefRepo.isActive,
                  onChanged: (val) async {
                    if (val)
                      chefsordersBloc.add(ChefsorderToAvailable());
                    else
                      chefsordersBloc.add(ChefsorderToUnAvailable());
                  },
                  activeColor: color4,
                  inactiveTrackColor: color3,
                )
              ],
            ),
          );
      },
    );
  }
}

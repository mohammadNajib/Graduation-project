import 'package:co_chef_mobile/Bloc/AddressesBloc/addresses_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Models/Address/Address.dart';
import 'package:co_chef_mobile/Repositories/AddressesRepo.dart';
import 'package:co_chef_mobile/Widgets/addressCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'AddAdressScreen.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

class AddressScreen extends StatefulWidget {
  static String route = "/AddressScreen";

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<Address> addresses = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (cotext) => AddressesBloc(AddressesRepo())..add(AddressesGetPersonalAddresses()),
        child: BlocBuilder<AddressesBloc, AddressesState>(builder: (context, state) {
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
              backgroundColor: color4,
              body: Container(
                height: MediaQuery.of(context).size.height * 0.82,
                child: ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AddressCard(
                      address: addresses[index],
                    );
                  },
                ),
              ),
              floatingActionButton: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: FloatingActionButton(
                  backgroundColor: color2,
                  child: Icon(
                    Icons.add,
                    color: color4,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AddAddressScreen.route);
                  },
                ),
              ),
            );
          } else if (state is AddressesNoInternetConnection)
            return Scaffold(
              body: Center(
                child: Text('No Internet connection'),
              ),
            );
          else {
            return Scaffold(
              body: Center(
                child: Text('Something Went Wrong'),
              ),
            );
          }
        }));
  }
}

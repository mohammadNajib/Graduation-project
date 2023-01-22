import 'package:co_chef_mobile/Bloc/AddressesBloc/addresses_bloc.dart';
import 'package:co_chef_mobile/Models/Address/Address.dart';
import 'package:co_chef_mobile/Screens/AddAdressScreen.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as Appcolors;
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  const AddressCard({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddressesBloc addressesBloc = BlocProvider.of<AddressesBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
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
                                color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          ),
                        ),
                        Text(address.name!, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                        Text(address.city! + '-' + address.area! + '-' + address.subarea!,
                            style: TextStyle(fontSize: 18.0)),
                        Text(address.details ?? ' ', style: TextStyle(fontSize: 18.0)),
                        Text('الطابق ${address.floor}'),
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
                color: Appcolors.color4,
                border: Border.all(color: Appcolors.color2, width: 1),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(address.name!, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                Text(address.city! + '-' + address.area!),
              ],
            ),
          ),
        ),
        Column(
          children: [
            GestureDetector(
                onTap: () => addressesBloc.add(AddressDelete(address.id!)),
                child: Icon(Icons.delete, color: Appcolors.color2, size: 35.0)),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddressScreen(address: address)));
              },
              child: Icon(Icons.edit_outlined, color: Appcolors.color2, size: 35.0),
            ),
          ],
        )
      ],
    );
  }
}

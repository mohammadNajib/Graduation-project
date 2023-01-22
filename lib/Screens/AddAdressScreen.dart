import 'package:co_chef_mobile/Bloc/AddressesBloc/addresses_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Models/Address/Address.dart';
import 'package:co_chef_mobile/Models/Address/AddressResponse.dart';
import 'package:co_chef_mobile/Repositories/AddressesRepo.dart';
import 'package:co_chef_mobile/Widgets/AppTextField.dart';
import 'package:co_chef_mobile/Widgets/PopUP.dart';
import 'package:co_chef_mobile/Widgets/TextListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'WelcomePage.dart';

class AddAddressScreen extends StatefulWidget {
  static String route = "/AddAddressScreen";
  final Address? address;

  const AddAddressScreen({Key? key, this.address}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  List<City> cities = [];
  List<Area> areas = [];
  List<Subarea> subAreas = [];

  AddressesRepo addressesRepo = AddressesRepo();
  late City cityDropdownValue;
  late Area areaDropdownValue;
  late Subarea subAreaDropdownValue;
  final TextEditingController floorController = TextEditingController();
  final TextEditingController detailesController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String longitude = ' ';
  String latitude = ' ';

  editAddress() {
    if (widget.address != null) {
      nameController.text = widget.address!.name!;
      detailesController.text = widget.address!.details!;
      floorController.text = widget.address!.floor!.toString();
    }
  }

  @override
  void initState() {
    editAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => AddressesBloc(addressesRepo)..add(AddressesGetCities()),
        child: BlocBuilder<AddressesBloc, AddressesState>(buildWhen: (previousState, state) {
          if (state is AddressesFailed)
            Fluttertoast.showToast(
                msg: state.errorMeassage,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          return true;
          // ignore: missing_return
        }, builder: (context, state) {
          if (state is AddressesLoading)
            return Scaffold(
                body: Center(
                    child: ScalingText(
              'Co-Chef',
              style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
            )));
          else if (state is AddressesDone || state is AddressesFailed) {
            cities = addressesRepo.cities;
            return Scaffold(
              backgroundColor: color4,
              body: ListView(
                children: [
                  AppTextField(
                    width: MediaQuery.of(context).size.width * 0.8,
                    controller: nameController,
                    hintText: 'اسم العنوان',
                    textInputType: TextInputType.text,
                  ),
                  TextListItem(text: 'المدينة'),
                  DropdownButton<City>(
                    value: cityDropdownValue,
                    hint: Center(child: Text('أختر مدينة')),
                    iconSize: 0,
                    elevation: 16,
                    style: appTextStyle,
                    underline: Container(width: MediaQuery.of(context).size.width * 0.8, height: 2, color: color2),
                    onChanged: (City? newValue) {
                      setState(() {
                        cityDropdownValue = newValue!;
                        areas = List.from(newValue.areas!);
                      });
                    },
                    items: cities.map<DropdownMenuItem<City>>((City value) {
                      return DropdownMenuItem<City>(value: value, child: Center(child: Text(value.name!)));
                    }).toList(),
                  ),
                  TextListItem(text: 'المنطقة'),
                  DropdownButton<Area>(
                    value: areaDropdownValue,
                    iconSize: 0,
                    elevation: 16,
                    style: appTextStyle,
                    underline: Container(height: 2, color: color2),
                    onChanged: (Area? newValue) {
                      setState(() {
                        areaDropdownValue = newValue!;
                        subAreas = newValue.subareas!;
                      });
                    },
                    items: areas.map<DropdownMenuItem<Area>>((Area value) {
                      return DropdownMenuItem<Area>(value: value, child: Center(child: Text(value.name!)));
                    }).toList(),
                  ),
                  TextListItem(text: 'الحي'),
                  DropdownButton<Subarea>(
                    value: subAreaDropdownValue,
                    iconSize: 0,
                    elevation: 16,
                    style: appTextStyle,
                    underline: Container(height: 2, color: color2),
                    onChanged: (Subarea? newValue) => setState(() => subAreaDropdownValue = newValue!),
                    items: subAreas.map<DropdownMenuItem<Subarea>>((Subarea value) {
                      return DropdownMenuItem<Subarea>(value: value, child: Center(child: Text(value.name!)));
                    }).toList(),
                  ),
                  AppTextField(
                    width: MediaQuery.of(context).size.width * 0.8,
                    controller: floorController,
                    hintText: 'الطابق',
                    textInputType: TextInputType.number,
                  ),
                  AppTextField(
                    width: MediaQuery.of(context).size.width * 0.8,
                    controller: detailesController,
                    hintText: 'تفاصيل إضافية',
                    textInputType: TextInputType.text,
                  ),
                  PopUp(
                    child: Text('GPS إضافة موقع', style: textStyle),
                    height: MediaQuery.of(context).size.height * 0.07,
                    onTap: () async {
                      Location location = new Location();

                      bool _serviceEnabled;
                      PermissionStatus _permissionGranted;
                      LocationData _locationData;

                      _serviceEnabled = await location.serviceEnabled();
                      if (!_serviceEnabled) {
                        _serviceEnabled = await location.requestService();
                        if (!_serviceEnabled) {
                          return;
                        }
                      }

                      _permissionGranted = await location.hasPermission();
                      if (_permissionGranted == PermissionStatus.denied) {
                        _permissionGranted = await location.requestPermission();
                        if (_permissionGranted != PermissionStatus.granted) {
                          return;
                        }
                      }

                      _locationData = await location.getLocation();
                      print('altitude : ' + '${_locationData.latitude}');
                      print('longitude : ' + '${_locationData.longitude}');
                      latitude = _locationData.latitude.toString();
                      longitude = _locationData.longitude.toString();
                      Fluttertoast.showToast(
                          msg: 'تمت إضافة GPS',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                  ),
                  PopUp(
                      child: Text('تأكيد', style: textStyle),
                      height: MediaQuery.of(context).size.height * 0.07,
                      onTap: () {
                        if (widget.address == null)
                          BlocProvider.of<AddressesBloc>(context).add(AddressesAdd(
                              nameController.text,
                              cityDropdownValue.id!,
                              areaDropdownValue.id!,
                              subAreaDropdownValue.id!,
                              floorController.text,
                              detailesController.text,
                              latitude,
                              longitude));
                        else {
                          BlocProvider.of<AddressesBloc>(context).add(AddressesEdit(
                              widget.address!.id!,
                              nameController.text,
                              cityDropdownValue.id!,
                              areaDropdownValue.id!,
                              subAreaDropdownValue.id!,
                              floorController.text,
                              detailesController.text,
                              latitude,
                              longitude));
                        }
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  )
                ],
              ),
            );
          } else if (state is AddressesNoInternetConnection)
            return Scaffold(
              body: Center(child: Text('No Internet Connection')),
            );
          else if (state is AddressesAddDone || state is AddressEditDone) {
            Fluttertoast.showToast(
                msg: 'تمت العملية بنجاح',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.pop(context);
            });
            return Scaffold();
          } else
            return Center(
              child: Text('Something Went Wrong'),
            );
        }));
  }
}

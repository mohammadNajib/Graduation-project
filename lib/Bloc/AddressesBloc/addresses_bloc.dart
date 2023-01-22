import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:co_chef_mobile/Models/Address/Address.dart';
import 'package:co_chef_mobile/Repositories/AddressesRepo.dart';
import 'package:meta/meta.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  AddressesBloc(this.addressesRepo) : super(AddressesInitial());

  final AddressesRepo addressesRepo;

  @override
  Stream<AddressesState> mapEventToState(
    AddressesEvent event,
  ) async* {
    if (event is AddressesGetCities) {
      yield AddressesLoading();
      await addressesRepo.loadCities();
      yield AddressesDone();
    } else if (event is AddressesAdd) {
      if (event.name == '')
        yield AddressesFailed('الرجاء اختيار اسم للعنوان');
      else {
        String test = await addressesRepo.addAddress(
            name: event.name,
            cityId: event.cityId,
            areaId: event.areaId,
            subareaId: event.subAreaId,
            floor: event.floor,
            details: event.details,
            latitude: event.latitude,
            longitude: event.longitude);
        yield AddressesAddDone(test);
      }
    } else if (event is AddressesGetPersonalAddresses) {
      yield AddressesLoading();
      // bool result = await InternetConnectionChecker().hasConnection;
      // if (result == true) {
      var addresses = await addressesRepo.loadPersonalAddresses();
      yield AddressesPersonalDone(addresses);
      // }
      //  else {
      //   yield AddressesNoInternetConnection();
      // }
    } else if (event is AddressesEdit) {
      yield AddressesLoading();
      // bool result = await InternetConnectionChecker().hasConnection;
      // if (result == true) {
      var message = await addressesRepo.editAddress(
          id: event.id,
          name: event.name,
          cityId: event.cityId,
          areaId: event.areaId,
          subareaId: event.subAreaId,
          details: event.details,
          floor: event.floor,
          latitude: event.latitude,
          longitude: event.longitude);
      yield AddressEditDone(message);
      // } else {
      //   yield AddressesNoInternetConnection();
      // }
    } else if (event is AddressDelete) {
      var message = await addressesRepo.deleteAddress(id: event.id);
      yield AddressesDeleteDone(message);
    }
  }
}

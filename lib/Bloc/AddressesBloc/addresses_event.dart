part of 'addresses_bloc.dart';

@immutable
abstract class AddressesEvent {}

class AddressesGetCities extends AddressesEvent {}

class AddressesAdd extends AddressesEvent {
  final String name;
  final int cityId;
  final int areaId;
  final int subAreaId;
  final String floor;
  final String details;
  final String latitude;
  final String longitude;

  AddressesAdd(this.name, this.cityId, this.areaId, this.subAreaId, this.floor,
      this.details, this.latitude, this.longitude);
}

class AddressesGetPersonalAddresses extends AddressesEvent {}

class AddressDelete extends AddressesEvent {
  final int id;

  AddressDelete(this.id);
}

class AddressesEdit extends AddressesEvent {
  final int id;
  final String name;
  final int cityId;
  final int areaId;
  final int subAreaId;
  final String floor;
  final String details;
  final String latitude;
  final String longitude;

  AddressesEdit(this.id, this.name, this.cityId, this.areaId, this.subAreaId,
      this.floor, this.details, this.latitude, this.longitude);
}

part of 'addresses_bloc.dart';

@immutable
abstract class AddressesState {}

class AddressesInitial extends AddressesState {}

class AddressesLoading extends AddressesState {}

class AddressesDone extends AddressesState {}

class AddressesFailed extends AddressesState {
  final String errorMeassage;

  AddressesFailed(this.errorMeassage);
}

class AddressesNoInternetConnection extends AddressesState {}

class AddressesPersonalDone extends AddressesState {
  final List<Address> addresses;

  AddressesPersonalDone(this.addresses);
}

class AddressesAddDone extends AddressesState {
  final String message;

  AddressesAddDone(this.message);
}

class AddressesDeleteDone extends AddressesState {
  final String message;

  AddressesDeleteDone(this.message);
}

class AddressEditDone extends AddressesState {
  final String message;

  AddressEditDone(this.message);
}

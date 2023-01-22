part of 'chefsorders_bloc.dart';

@immutable
abstract class ChefsordersEvent {}

class ChefsorderFetch extends ChefsordersEvent {}

class ChefsorderAccept extends ChefsordersEvent {
  final int id;

  ChefsorderAccept(this.id);
}

class ChefsorderReject extends ChefsordersEvent {
  final int id;

  ChefsorderReject(this.id);
}

class ChefsorderToAvailable extends ChefsordersEvent {}

class ChefsorderToUnAvailable extends ChefsordersEvent {}

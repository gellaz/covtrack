part of 'houses_bloc.dart';

abstract class HousesState extends Equatable {
  const HousesState();
}

class HousesInitial extends HousesState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'HousesInitial';
}

class HousesLoadInProgress extends HousesState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'HousesLoadInProgress';
}

class HousesLoadSuccess extends HousesState {
  final List<House> houses;

  const HousesLoadSuccess({this.houses});

  @override
  List<Object> get props => [houses];

  @override
  String toString() => 'HousesLoadSuccess {houses: $houses}';
}

class HousesLoadFailure extends HousesState {
  final String message;

  const HousesLoadFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'HousesLoadFailure {message: $message}';
}

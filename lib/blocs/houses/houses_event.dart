part of 'houses_bloc.dart';

abstract class HousesEvent extends Equatable {
  const HousesEvent();
}

class LoggedIn extends HousesEvent {
  const LoggedIn();
  @override
  List<Object> get props => [];
}

class HouseAdded extends HousesEvent {
  final House house;

  const HouseAdded(this.house);

  @override
  List<Object> get props => [house];

  @override
  String toString() => 'HouseAdded {house: $house}';
}

class HouseRemoved extends HousesEvent {
  final House house;

  const HouseRemoved(this.house);

  @override
  List<Object> get props => [house];

  @override
  String toString() => 'HouseRemoved {house: $house}';
}

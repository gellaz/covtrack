part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationStarted extends LocationEvent {}

class LocationChanged extends LocationEvent {
  final Position position;

  const LocationChanged(this.position);

  @override
  List<Object> get props => [position];

  @override
  String toString() => 'LocationChanged { position: $position }';
}

part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {
  final int numStops;

  const LocationInitial(this.numStops);

  @override
  List<Object> get props => [numStops];

  @override
  String toString() => 'LocationInitial { numStops: $numStops }';
}

class LocationLoadInProgress extends LocationState {}

class LocationLoadSuccess extends LocationState {
  final Position position;
  final int numStops;

  const LocationLoadSuccess(this.position, this.numStops);

  @override
  List<Object> get props => [position, numStops];

  @override
  String toString() =>
      'LocationLoadSuccess { position: $position, numStops: $numStops }';
}

class LocationLoadFailure extends LocationState {
  final String message;

  const LocationLoadFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'LocationLoadFailure { message: $message }';
}

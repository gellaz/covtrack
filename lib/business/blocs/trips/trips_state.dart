part of 'trips_bloc.dart';

abstract class TripsState extends Equatable {
  const TripsState();
}

class TripsInitial extends TripsState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'TripsInitial';
}

class TripsLoadInProgress extends TripsState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'TripsLoadInProgress';
}

class TripsLoadSuccess extends TripsState {
  final List<Trip> trips;

  const TripsLoadSuccess(this.trips);

  @override
  List<Object> get props => [trips];

  @override
  String toString() => 'TripsLoadSuccess {trips: $trips}';
}

class TripsLoadFailure extends TripsState {
  final String message;

  const TripsLoadFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'TripsLoadFailure {message: $message}';
}

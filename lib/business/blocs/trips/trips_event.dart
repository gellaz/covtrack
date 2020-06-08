part of 'trips_bloc.dart';

abstract class TripsEvent extends Equatable {
  const TripsEvent();

  @override
  List<Object> get props => [];
}

class LoadTrips extends TripsEvent {}

class AddTrip extends TripsEvent {
  final Trip trip;

  const AddTrip(this.trip);

  @override
  List<Object> get props => [trip];

  @override
  String toString() => 'AddTrip { trip: $trip }';
}

class UpdateTrip extends TripsEvent {
  final Trip trip;

  const UpdateTrip(this.trip);

  @override
  List<Object> get props => [trip];

  @override
  String toString() => 'UpdateTrip { trip: $trip }';
}

class DeleteTrip extends TripsEvent {
  final Trip trip;

  const DeleteTrip(this.trip);

  @override
  List<Object> get props => [trip];

  @override
  String toString() => 'DeleteTrip { trip: $trip }';
}

class Clear extends TripsEvent {}

class TripsUpdated extends TripsEvent {
  final List<Trip> trips;

  const TripsUpdated(this.trips);

  @override
  List<Object> get props => [trips];
}

part of 'trips_bloc.dart';

/// The [TripsBloc] will need to know how to process the following events:
/// [LoadTrips] - informs the [TripsBloc] to load the list of all user's trips.
/// [AddTrip] - informs the [TripsBloc] to add a trip to the list of user's trips.
/// [UpdateTrip] -  informs the [TripsBloc] that a trip has been updated.
/// [DeleteTrip] -  informs the [TripsBloc] that a trip has been deleted.
/// [TripsCleared] - informs the [TripsBloc] the all user's trips should be deleted.
/// [TripsUpdated] - event that groups all the previous events.
abstract class TripsEvent extends Equatable {
  const TripsEvent();

  @override
  List<Object> get props => [];
}

class LoadTrips extends TripsEvent {}

class AddTrip extends TripsEvent {
  final Trip trip;

  const AddTrip({@required this.trip});

  @override
  List<Object> get props => [trip];

  @override
  String toString() => 'AddTrip { trip: $trip }';
}

class UpdateTrip extends TripsEvent {
  final Trip trip;

  const UpdateTrip({@required this.trip});

  @override
  List<Object> get props => [trip];

  @override
  String toString() => 'UpdateTrip { trip: $trip }';
}

class DeleteTrip extends TripsEvent {
  final Trip trip;

  const DeleteTrip({@required this.trip});

  @override
  List<Object> get props => [trip];

  @override
  String toString() => 'DeleteTrip { trip: $trip }';
}

class TripsCleared extends TripsEvent {}

class TripsUpdated extends TripsEvent {
  final List<Trip> trips;

  const TripsUpdated({@required this.trips});

  @override
  List<Object> get props => [trips];

  @override
  String toString() => 'TripsUpdated { trips: $trips }';
}

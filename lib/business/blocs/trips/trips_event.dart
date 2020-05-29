part of 'trips_bloc.dart';

abstract class TripsEvent extends Equatable {
  const TripsEvent();

  @override
  List<Object> get props => [];
}

class TripsLoaded extends TripsEvent {}

class TripAdded extends TripsEvent {
  final Trip trip;

  const TripAdded(this.trip);

  @override
  List<Object> get props => [trip];

  @override
  String toString() => 'TripAdded { trip: $trip }';
}

class TripDeleted extends TripsEvent {
  final Trip trip;

  const TripDeleted(this.trip);

  @override
  List<Object> get props => [trip];

  @override
  String toString() => 'TripDeleted { trip: $trip }';
}

class TripUpdated extends TripsEvent {
  final Trip trip;

  const TripUpdated(this.trip);

  @override
  List<Object> get props => [trip];

  @override
  String toString() => 'TripUpdated { trip: $trip }';
}

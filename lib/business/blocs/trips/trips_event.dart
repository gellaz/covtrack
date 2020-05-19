part of 'trips_bloc.dart';

abstract class TripsEvent extends Equatable {
  const TripsEvent();
}

class TripAdded extends TripsEvent {
  final Trip trip;

  const TripAdded(this.trip);

  @override
  List<Object> get props => [trip];
}

class TripsLoaded extends TripsEvent {
  @override
  List<Object> get props => [];
}

class TripDeleted extends TripsEvent {
  final Trip trip;

  const TripDeleted(this.trip);

  @override
  List<Object> get props => [trip];
}

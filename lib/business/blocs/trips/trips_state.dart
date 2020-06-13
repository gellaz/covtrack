part of 'trips_bloc.dart';

/// The [TripsBloc] state can be one of the following:
/// [TripsInitial] - ready to fetch trips data.
/// [TripsLoadInProgress] - loading trips data.
/// [TripsLoadSuccess] - abstract state for trips data loaded successfully.
/// [TripsLoadSuccessActive] - trips data loaded successfully and the last trip is currently active.
/// [TripsLoadSuccessNotActive] - trips data loaded successfully and there are no active trips.
/// [TripsEmpty] - the list of trips loaded is empty.
/// [TripsLoadFailure] - an error has occurred while loading trips data.
abstract class TripsState extends Equatable {
  const TripsState();

  @override
  List<Object> get props => [];
}

class TripsInitial extends TripsState {}

class TripsLoadInProgress extends TripsState {}

abstract class TripsLoadSuccess extends TripsState {
  final List<Trip> trips;

  const TripsLoadSuccess({this.trips});

  @override
  List<Object> get props => [trips];
}

class TripsLoadSuccessActive extends TripsLoadSuccess {
  const TripsLoadSuccessActive(List<Trip> trips) : super(trips: trips);

  @override
  String toString() => 'TripsLoadSuccessActive { trips: $trips }';
}

class TripsLoadSuccessNotActive extends TripsLoadSuccess {
  const TripsLoadSuccessNotActive(List<Trip> trips) : super(trips: trips);

  @override
  String toString() => 'TripsLoadSuccessNotActive { trips: $trips }';
}

class TripsLoadSuccessEmpty extends TripsLoadSuccess {}

class TripsLoadFailure extends TripsState {
  final String message;

  const TripsLoadFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'TripsLoadFailure { message: $message }';
}

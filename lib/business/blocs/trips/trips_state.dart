part of 'trips_bloc.dart';

abstract class TripsState extends Equatable {
  const TripsState();

  @override
  List<Object> get props => [];
}

class TripsInitial extends TripsState {}

class TripsLoadInProgress extends TripsState {}

class TripsLoadSuccess extends TripsState {
  final List<Trip> trips;

  const TripsLoadSuccess(this.trips);

  @override
  List<Object> get props => [trips];

  @override
  String toString() => 'TripsLoadSuccessActive { trips: $trips }';
}

class TripsLoadSuccessActive extends TripsLoadSuccess {
  const TripsLoadSuccessActive(List<Trip> trips) : super(trips);
}

class TripsLoadSuccessNotActive extends TripsLoadSuccess {
  const TripsLoadSuccessNotActive(List<Trip> trips) : super(trips);
}

class TripsEmpty extends TripsState {}

class TripsLoadFailure extends TripsState {
  final String message;

  const TripsLoadFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'TripsLoadFailure { message: $message }';
}

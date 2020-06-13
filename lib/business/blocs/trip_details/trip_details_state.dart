part of 'trip_details_bloc.dart';

/// The [TripDetailsBloc] state can be one of the following:
/// [TripDetailsInitial] - trip details screen not loaded.
/// [UserPlaceLoading] - user place loading.
/// [UserPlaceSuccess] - user place loaded successfully.
/// [UserPlaceError] - user place loding process failed.
/// [NewReason] - new reason selected.
abstract class TripDetailsState extends Equatable {
  const TripDetailsState();

  @override
  List<Object> get props => [];
}

class TripDetailsInitial extends TripDetailsState {}

class UserPlaceLoading extends TripDetailsState {}

class UserPlaceSuccess extends TripDetailsState {
  final Place place;

  const UserPlaceSuccess(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'UserPlaceSuccess { place: $place }';
}

class UserPlaceError extends TripDetailsState {}

class NewReason extends TripDetailsState {
  final String reason;

  const NewReason(this.reason);

  @override
  List<Object> get props => [reason];

  @override
  String toString() => 'NewReason { reason: $reason }';
}

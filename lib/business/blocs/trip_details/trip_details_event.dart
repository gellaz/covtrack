part of 'trip_details_bloc.dart';

/// The [TripDetailsBloc] will need to know how to process the following events:
/// [LoadCurrentPlace] - informs the [TripDetailsBloc] that user's current place should be retrieved.
/// [SelectNewReason] - informs the [TripDetailsBloc] that the user selected a new reason for the trip.
abstract class TripDetailsEvent extends Equatable {
  const TripDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentPlace extends TripDetailsEvent {}

class SelectNewReason extends TripDetailsEvent {
  final String reason;

  const SelectNewReason({@required this.reason});

  @override
  List<Object> get props => [reason];

  @override
  String toString() => 'SelectNewReason { reason: $reason }';
}

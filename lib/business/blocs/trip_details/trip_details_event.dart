part of 'trip_details_bloc.dart';

abstract class TripDetailsEvent extends Equatable {
  const TripDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentPlace extends TripDetailsEvent {}

class SelectNewReason extends TripDetailsEvent {
  final String reason;

  const SelectNewReason(this.reason);

  @override
  List<Object> get props => [reason];

  @override
  String toString() => 'SelectNewReason { reason: $reason }';
}

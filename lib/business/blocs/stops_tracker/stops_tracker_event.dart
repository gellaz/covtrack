part of 'stops_tracker_bloc.dart';

/// The [StopsTrackerBloc] will need to know how to process the following events:
/// [StartTracking] - informs the [StopsTrackerBloc] to start tracking user's location changes.
/// [NewStopRecorded] - informs the [StopsTrackerBloc] that the user made a new stop.
/// [StopTracking] - informs the [StopsTrackerBloc] to stop tracking user's location changes.
abstract class StopsTrackerEvent extends Equatable {
  const StopsTrackerEvent();

  @override
  List<Object> get props => [];
}

class StartTracking extends StopsTrackerEvent {}

class NewStopRecorded extends StopsTrackerEvent {
  final Stop stop;

  const NewStopRecorded({@required this.stop});

  @override
  List<Object> get props => [stop];

  @override
  String toString() => 'NewStopRecorded { stop: $stop }';
}

class StopTracking extends StopsTrackerEvent {}

part of 'stops_tracker_bloc.dart';

abstract class StopsTrackerEvent extends Equatable {
  const StopsTrackerEvent();

  @override
  List<Object> get props => [];
}

class StartTracking extends StopsTrackerEvent {}

class NewStopRecorded extends StopsTrackerEvent {
  final Stop stop;

  const NewStopRecorded(this.stop);

  @override
  List<Object> get props => [stop];

  @override
  String toString() => 'NewStopRecorded { stop: $stop }';
}

class StopTracking extends StopsTrackerEvent {}

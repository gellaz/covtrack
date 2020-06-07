part of 'stops_tracker_bloc.dart';

abstract class StopsTrackerState extends Equatable {
  final List<Stop> stops;

  const StopsTrackerState(this.stops);

  @override
  List<Object> get props => [stops];
}

class Ready extends StopsTrackerState {
  const Ready(List<Stop> stops) : super(stops);

  @override
  String toString() => 'Ready { stops: $stops }';
}

class Running extends StopsTrackerState {
  const Running(List<Stop> stops) : super(stops);

  @override
  String toString() => 'Running { stops: $stops }';
}

class Paused extends StopsTrackerState {
  const Paused(List<Stop> stops) : super(stops);

  @override
  String toString() => 'Paused { stops: $stops }';
}

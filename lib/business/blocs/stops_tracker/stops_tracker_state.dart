part of 'stops_tracker_bloc.dart';

/// The [StopsTrackerState] state can be one of the following:
/// [Ready] - ready to start tracking user's stops.
/// [Running] - actively tracking user's stops.
/// [Paused] - paused with some stops recorded.
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

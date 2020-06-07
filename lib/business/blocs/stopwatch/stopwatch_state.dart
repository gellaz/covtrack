part of 'stopwatch_bloc.dart';

abstract class StopwatchState extends Equatable {
  final Duration elapsedTime;

  const StopwatchState(this.elapsedTime);

  @override
  List<Object> get props => [elapsedTime];
}

class Ready extends StopwatchState {
  Ready(Duration elapsedTime) : super(elapsedTime);

  @override
  String toString() => 'Ready { elapsedTime: $elapsedTime }';
}

class Running extends StopwatchState {
  Running(Duration elapsedTime) : super(elapsedTime);

  @override
  String toString() => 'Running { elapsedTime: $elapsedTime }';
}

class Paused extends StopwatchState {
  Paused(Duration elapsedTime) : super(elapsedTime);

  @override
  String toString() => 'Paused { elapsedTime: $elapsedTime }';
}

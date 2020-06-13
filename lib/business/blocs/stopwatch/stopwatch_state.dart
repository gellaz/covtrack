part of 'stopwatch_bloc.dart';

/// The [StopwatchBloc] state can be one of the following:
/// [StopwatchInitial] - ready to start counting given an initail elapsed time.
/// [StopwatchRunInProgess] - actively counting from the specified elapsed time.
/// [StopwatchRunPause] - paused with some elapsed time.
abstract class StopwatchState extends Equatable {
  final Duration elapsedTime;

  const StopwatchState(this.elapsedTime);

  @override
  List<Object> get props => [elapsedTime];
}

class StopwatchInitial extends StopwatchState {
  StopwatchInitial(Duration elapsedTime) : super(elapsedTime);

  @override
  String toString() => 'StopwatchInitial { elapsedTime: $elapsedTime }';
}

class StopwatchRunInProgess extends StopwatchState {
  StopwatchRunInProgess(Duration elapsedTime) : super(elapsedTime);

  @override
  String toString() => 'StopwatchRunInProgess { elapsedTime: $elapsedTime }';
}

class StopwatchRunPause extends StopwatchState {
  StopwatchRunPause(Duration elapsedTime) : super(elapsedTime);

  @override
  String toString() => 'StopwatchRunPause { elapsedTime: $elapsedTime }';
}

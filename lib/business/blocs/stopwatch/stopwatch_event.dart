part of 'stopwatch_bloc.dart';

/// The [StopwatchBloc] will need to know how to process the following events:
/// [StopwatchStarted] - informs the [StopwatchBloc] that the stopwatch should be started.
/// [StopwatchTicked] - informs the [StopwatchBloc] that the stopwatch should be paused.
/// [StopwatchPaused] -  informs the [StopwatchBloc] that the timer should be reset to the original state.
/// [StopwatchReset] -  informs the [StopwatchBloc] that a tick has occurred and that it needs to update its state accordingly.
abstract class StopwatchEvent extends Equatable {
  const StopwatchEvent();
  @override
  List<Object> get props => [];
}

class StopwatchStarted extends StopwatchEvent {}

class StopwatchTicked extends StopwatchEvent {}

class StopwatchPaused extends StopwatchEvent {}

class StopwatchReset extends StopwatchEvent {}

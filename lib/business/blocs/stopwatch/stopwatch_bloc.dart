import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'stopwatch_event.dart';
part 'stopwatch_state.dart';

/// BLoC responsible for the business logic behind the stopwatch measuring the
/// elapsed time since the start of the active trip. In particular this BLoC
/// will map the incoming [StopwatchEvent] to the correct [StopwatchState].
class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  /// Active trip starting time.
  final DateTime startingTime;

  /// Stopwatch to measure the elapsed time since the start of the trip.
  final Stopwatch _stopwatch;

  /// Periodic count-down timer that calls the _update function every second.
  Timer _timer;

  StopwatchBloc({@required this.startingTime})
      : assert(startingTime != null),
        _stopwatch = Stopwatch(),
        super(StopwatchInitial(DateTime.now().difference(startingTime)));

  void _update(Timer _timer) {
    if (_stopwatch.isRunning) {
      add(StopwatchTicked());
    }
  }

  @override
  Stream<StopwatchState> mapEventToState(
    StopwatchEvent event,
  ) async* {
    if (event is StopwatchStarted) {
      yield* _mapStopwatchStartedToState();
    } else if (event is StopwatchTicked) {
      yield* _mapStopwatchTickedToState();
    } else if (event is StopwatchPaused) {
      yield* _mapStopwatchPausedToState();
    } else if (event is StopwatchReset) {
      yield* _mapStopwatchResetToState();
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Stream<StopwatchState> _mapStopwatchStartedToState() async* {
    _timer?.cancel();
    _stopwatch.start();
    _timer = Timer.periodic(Duration(seconds: 1), _update);
  }

  Stream<StopwatchState> _mapStopwatchTickedToState() async* {
    yield StopwatchRunInProgess(DateTime.now().difference(startingTime));
  }

  Stream<StopwatchState> _mapStopwatchPausedToState() async* {
    _stopwatch.stop();
    yield StopwatchRunPause(DateTime.now().difference(startingTime));
  }

  Stream<StopwatchState> _mapStopwatchResetToState() async* {
    _stopwatch.reset();
    yield StopwatchInitial(Duration.zero);
  }
}

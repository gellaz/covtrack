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
  /// Time elapsed since the start of the trip.
  final Duration startingTime;

  /// Stopwatch to measure the elapsed time since the start of the trip.
  final Stopwatch _stopwatch;

  /// Periodic count-down timer that calls the _update function every second.
  Timer _timer;

  StopwatchBloc({@required this.startingTime})
      : assert(startingTime != null),
        _stopwatch = Stopwatch();

  void _update(Timer _timer) {
    if (_stopwatch.isRunning) {
      add(StopwatchTicked());
    }
  }

  @override
  StopwatchState get initialState => StopwatchInitial(startingTime);

  @override
  Stream<StopwatchState> mapEventToState(
    StopwatchEvent event,
  ) async* {
    if (event is StopwatchStarted) {
      yield* _mapStartToState();
    } else if (event is StopwatchTicked) {
      yield* _mapTickToState();
    } else if (event is StopwatchPaused) {
      yield* _mapStopToState();
    } else if (event is StopwatchReset) {
      yield* _mapResetToState();
    }
  }

  Stream<StopwatchState> _mapStartToState() async* {
    _timer?.cancel();
    _stopwatch.start();
    _timer = Timer.periodic(Duration(seconds: 1), _update);
  }

  Stream<StopwatchState> _mapTickToState() async* {
    yield StopwatchRunInProgess(_stopwatch.elapsed);
  }

  Stream<StopwatchState> _mapStopToState() async* {
    _stopwatch.stop();
    yield StopwatchRunPause(_stopwatch.elapsed);
  }

  Stream<StopwatchState> _mapResetToState() async* {
    _stopwatch.reset();
    yield StopwatchInitial(Duration.zero);
  }
}

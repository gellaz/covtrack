import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'stopwatch_event.dart';
part 'stopwatch_state.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  final Stopwatch _stopwatch = Stopwatch();
  final Duration startingTime;

  StopwatchBloc({@required this.startingTime}) : assert(startingTime != null);
  Timer timer;
  Duration elapsedTime;

  void _update(Timer timer) {
    if (_stopwatch.isRunning) {
      add(Tick());
    }
  }

  @override
  StopwatchState get initialState => Ready(startingTime);

  @override
  Stream<StopwatchState> mapEventToState(
    StopwatchEvent event,
  ) async* {
    if (event is Start) {
      yield* _mapStartToState();
    } else if (event is Tick) {
      yield* _mapTickToState();
    } else if (event is Stop) {
      yield* _mapStopToState();
    } else if (event is Reset) {
      yield* _mapResetToState();
    }
  }

  Stream<StopwatchState> _mapStartToState() async* {
    _stopwatch.start();
    timer = Timer.periodic(Duration(seconds: 1), _update);
  }

  Stream<StopwatchState> _mapTickToState() async* {
    yield Running(_stopwatch.elapsed);
  }

  Stream<StopwatchState> _mapStopToState() async* {
    _stopwatch.stop();
    timer = null;
    yield Paused(_stopwatch.elapsed);
  }

  Stream<StopwatchState> _mapResetToState() async* {
    _stopwatch.reset();
    yield Ready(Duration.zero);
  }
}

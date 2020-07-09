import 'package:covtrack/business/blocs/stopwatch/stopwatch_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('StopwatchBloc', () {
    final DateTime startingTime = DateTime.now().add(Duration(hours: -1));
    StopwatchBloc stopwatchBloc;

    setUp(() {
      stopwatchBloc = StopwatchBloc(startingTime: startingTime);
    });

    tearDown(() {
      stopwatchBloc?.close();
    });

    test('throws AssertionError if startingTime is null', () {
      expect(
        () => StopwatchBloc(startingTime: null),
        throwsA(isAssertionError),
      );
    });

    test(
        'initial state is StopwatchInitial with the given initial elapsed time',
        () {
      expect(
        stopwatchBloc.state,
        isA<StopwatchInitial>(),
      );
    });

    test('close does not emit new states', () {
      expectLater(
        stopwatchBloc,
        emitsInOrder([
          isA<StopwatchInitial>(),
          emitsDone,
        ]),
      );
      stopwatchBloc.close();
    });

    group('StopwatchStarted', () {
      blocTest(
        'emits [StopwatchRunInProgess] n times if I wait n seconds',
        build: () async => stopwatchBloc,
        act: (bloc) => bloc.add(StopwatchStarted()),
        wait: const Duration(seconds: 4),
        expect: [
          isA<StopwatchRunInProgess>(),
          isA<StopwatchRunInProgess>(),
          isA<StopwatchRunInProgess>(),
        ],
      );
    });

    group('StopwatchPaused', () {
      blocTest(
        'correctly stops the stopwatch',
        build: () async => stopwatchBloc,
        act: (bloc) async =>
            bloc..add(StopwatchStarted())..add(StopwatchPaused()),
        expect: [
          isA<StopwatchRunPause>(),
        ],
      );
    });

    group('StopwatchReset', () {
      blocTest(
        'correctly resets the stopwatch to zero',
        build: () async => stopwatchBloc,
        act: (bloc) async => bloc.add(StopwatchStarted()),
        expect: [
          //StopwatchInitial(Duration.zero),
        ],
      );
    });
  });
}

import 'package:covtrack/business/blocs/stopwatch/stopwatch_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  // Starting time is one hour ago.
  DateTime startingTime = DateTime.now().add(Duration(hours: -1));
  StopwatchBloc stopwatchBloc;

  group('StopwatchBloc', () {
    setUp(() {
      stopwatchBloc = StopwatchBloc(startingTime: startingTime);
    });

    test('throws AssertionError if startingTime is null', () {
      expect(
        () => StopwatchBloc(startingTime: null),
        throwsA(isAssertionError),
      );
    });
    test(
        'initial state is StopwatchInitial with elapsed time from startingTime',
        () {
      expect(
        stopwatchBloc.state,
        StopwatchInitial(DateTime.now().difference(startingTime)),
      );
    });
  });
}

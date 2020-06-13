import 'package:covtrack/business/blocs/trips/trips_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TripsBloc', () {
    test('throws AssertionError if TripsRepository is null', () {
      expect(
        () => TripsBloc(tripsRepository: null),
        throwsA(isAssertionError),
      );
    });
  });
}

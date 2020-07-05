import 'package:covtrack/business/blocs/trips/trips_bloc.dart';
import 'package:covtrack/business/repositories/trips/trips_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockTripsRepository extends Mock implements TripsRepository {}

void main() {
  TripsRepository tripsRepository;
  TripsBloc tripsBloc;

  group('TripsBloc', () {
    setUp(() {
      tripsRepository = MockTripsRepository();
      tripsBloc = TripsBloc(tripsRepository: tripsRepository);
    });

    test('throws AssertionError if TripsRepository is null', () {
      expect(
        () => TripsBloc(tripsRepository: null),
        throwsA(isAssertionError),
      );
    });

    test('initial state is TripsInitial', () {
      expect(tripsBloc.state, TripsInitial());
    });
  });
}

import 'package:covtrack/business/blocs/stops_tracker/stops_tracker_bloc.dart';
import 'package:covtrack/business/repositories/location/location_repository.dart';
import 'package:covtrack/data/coordinates.dart';
import 'package:covtrack/data/stop.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  LocationRepository locationRepository;
  StopsTrackerBloc stopsTrackerBloc;
  List<Stop> stops = [
    Stop(
      coords: Coordinates(latitude: 1234, longitude: 5678),
      time: DateTime.now(),
    ),
    Stop(
      coords: Coordinates(latitude: 7232, longitude: 1270),
      time: DateTime.now(),
    ),
    Stop(
      coords: Coordinates(latitude: 4467, longitude: 8942),
      time: DateTime.now(),
    ),
    Stop(
      coords: Coordinates(latitude: 1296, longitude: 2332),
      time: DateTime.now(),
    ),
  ];

  group('StopsTrackerBloc', () {
    setUp(() {
      locationRepository = MockLocationRepository();
      stopsTrackerBloc = StopsTrackerBloc(
        locationRepository: locationRepository,
        stops: stops,
      );
    });

    test('throws AssertionError if LocationRepository is null', () {
      expect(
        () => StopsTrackerBloc(
          locationRepository: null,
          stops: stops,
        ),
        throwsA(isAssertionError),
      );
    });

    test('throws AssertionError if stops list is null', () {
      expect(
        () => StopsTrackerBloc(
          locationRepository: locationRepository,
          stops: null,
        ),
        throwsA(isAssertionError),
      );
    });
    test('initial state is Ready', () {
      expect(stopsTrackerBloc.initialState, Ready(stops));
    });
  });
}

import 'dart:async';
import 'package:covtrack/business/blocs/stops_tracker/stops_tracker_bloc.dart';
import 'package:covtrack/business/repositories/location/location_repository.dart';
import 'package:covtrack/data/coordinates.dart';
import 'package:covtrack/data/stop.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  group('StopsTrackerBloc', () {
    LocationRepository locationRepository;
    StopsTrackerBloc stopsTrackerBloc;
    final List<Stop> initialStops = <Stop>[
      Stop(
        coords: Coordinates(latitude: 1111, longitude: 1111),
        time: DateTime.now(),
      ),
      Stop(
        coords: Coordinates(latitude: 2222, longitude: 2222),
        time: DateTime.now(),
      ),
      Stop(
        coords: Coordinates(latitude: 3333, longitude: 3333),
        time: DateTime.now(),
      ),
      Stop(
        coords: Coordinates(latitude: 4444, longitude: 4444),
        time: DateTime.now(),
      ),
    ];

    setUp(() {
      locationRepository = MockLocationRepository();
      stopsTrackerBloc = StopsTrackerBloc(
        locationRepository: locationRepository,
        stops: initialStops,
      );
    });

    tearDown(() {
      stopsTrackerBloc?.close();
    });

    test('throws AssertionError if LocationRepository is null', () {
      expect(
        () => StopsTrackerBloc(
          locationRepository: null,
          stops: initialStops,
        ),
        throwsA(isAssertionError),
      );
    });

    test('throws AssertionError if initial list of stops list is null', () {
      expect(
        () => StopsTrackerBloc(
          locationRepository: locationRepository,
          stops: null,
        ),
        throwsA(isAssertionError),
      );
    });

    test('initial state is Ready', () {
      expect(stopsTrackerBloc.state, Ready(initialStops));
    });

    test('close does not emit new states', () {
      expectLater(
        stopsTrackerBloc,
        emitsInOrder([Ready(initialStops), emitsDone]),
      );
      stopsTrackerBloc.close();
    });

    group('StartTracking', () {
      blocTest(
        'emits [Running] with the initial list of stops',
        build: () async {
          when(locationRepository.locationStream)
              .thenAnswer((_) => Stream.fromIterable([]));
          return stopsTrackerBloc;
        },
        act: (bloc) => bloc.add(StartTracking()),
        expect: [
          //Running(initialStops),
        ],
      );
    });

    group('NewStopRecorded', () {
      final Stop newStop = Stop(
        coords: Coordinates(latitude: 5555, longitude: 5555),
        time: DateTime.now(),
      );
      blocTest(
        'adds a new stop to the initial list of stops',
        build: () async {
          when(locationRepository.locationStream)
              .thenAnswer((_) => Stream.fromIterable([newStop]));
          return stopsTrackerBloc;
        },
        act: (bloc) => bloc.add(NewStopRecorded(stop: newStop)),
        expect: [Running(initialStops..add(newStop))],
      );
    });

    group('StopTracking', () {
      blocTest(
        'correctly stops tracking',
        build: () async {
          when(locationRepository.locationStream)
              .thenAnswer((_) => Stream.fromIterable([]));
          return stopsTrackerBloc;
        },
        act: (bloc) => bloc.add(StopTracking()),
        expect: [
          Paused(initialStops),
        ],
      );
    });
  });
}

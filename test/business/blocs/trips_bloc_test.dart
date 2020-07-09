import 'package:covtrack/business/blocs/trips/trips_bloc.dart';
import 'package:covtrack/business/repositories/trips/trips_repository.dart';
import 'package:covtrack/data/coordinates.dart';
import 'package:covtrack/data/place.dart';
import 'package:covtrack/data/stop.dart';
import 'package:covtrack/data/trip.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockTripsRepository extends Mock implements TripsRepository {}

void main() {
  group('TripsBloc', () {
    TripsRepository tripsRepository;
    TripsBloc tripsBloc;

    final Trip trip1 = Trip(
      tripId: 'ABCD_1234',
      reason: 'Proven work needs',
      startingTime: DateTime(2020, 1, 15, 10, 30, 20, 99, 137),
      arrivalTime: null,
      source: Place(
        placeId: 'ABCD1234',
        coords: Coordinates(latitude: 12.34, longitude: 56.78),
        formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
        name: 'Viale Rossi, 4',
      ),
      destination: Place(
        placeId: 'WXYZ5678',
        coords: Coordinates(latitude: 21.43, longitude: 65.87),
        formattedAddress: 'Via Verdi, 2, 40120 Bologna BO, Italy',
        name: 'Best Supermarket',
      ),
      stops: <Stop>[],
    );

    final Trip trip2 = Trip(
      tripId: 'WXYZ_5678',
      reason: 'Health reasons',
      startingTime: DateTime(2020, 1, 16, 10, 30, 20, 99, 137),
      arrivalTime: null,
      source: Place(
        placeId: 'ABCD1234',
        coords: Coordinates(latitude: 12.34, longitude: 56.78),
        formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
        name: 'Viale Rossi, 4',
      ),
      destination: Place(
        placeId: 'WXYZ5678',
        coords: Coordinates(latitude: 21.43, longitude: 65.87),
        formattedAddress: 'Via Verdi, 2, 40120 Bologna BO, Italy',
        name: 'Best Supermarket',
      ),
      stops: <Stop>[],
    );

    final Trip updatedTrip1 = Trip(
      tripId: 'ABCD_1234',
      reason: 'Proven work needs',
      startingTime: DateTime(2020, 1, 15, 10, 30, 20, 99, 137),
      arrivalTime: DateTime(2020, 1, 15, 12, 5, 20, 99, 224),
      source: Place(
        placeId: 'ABCD1234',
        coords: Coordinates(latitude: 12.34, longitude: 56.78),
        formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
        name: 'Viale Rossi, 4',
      ),
      destination: Place(
        placeId: 'WXYZ5678',
        coords: Coordinates(latitude: 21.43, longitude: 65.87),
        formattedAddress: 'Via Verdi, 2, 40120 Bologna BO, Italy',
        name: 'Best Supermarket',
      ),
      stops: <Stop>[],
    );

    setUp(() {
      tripsRepository = MockTripsRepository();
      tripsBloc = TripsBloc(tripsRepository: tripsRepository);
    });

    tearDown(() {
      tripsBloc?.close();
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

    test('close does not emit new states', () {
      expectLater(
        tripsBloc,
        emitsInOrder([TripsInitial(), emitsDone]),
      );
      tripsBloc.close();
    });

    blocTest(
      'should emit TripsLoadFailure if repository throws',
      build: () async {
        when(tripsRepository.trips()).thenThrow(Exception('oops'));
        return tripsBloc;
      },
      act: (bloc) async => bloc.add(LoadTrips()),
      expect: [
        TripsLoadInProgress(),
        TripsLoadFailure(),
      ],
    );

    test(
        'emits [TripsLoadInProgress, TripsLoadSuccessEmpty] when trips loaded for the first time',
        () {
      when(tripsRepository.trips()).thenAnswer((_) => Stream.fromIterable([]));
      tripsBloc.add(LoadTrips());
      emitsExactly(
        tripsBloc,
        [TripsLoadInProgress(), TripsLoadSuccessEmpty()],
      );
    });

    test('should add a trip to the list in response to an AddTrip event', () {
      when(tripsRepository.trips()).thenAnswer((_) => Stream.fromIterable([]));
      tripsBloc..add(LoadTrips())..add(AddTrip(trip: trip1));
      emitsExactly(
        tripsBloc,
        [
          TripsLoadInProgress(),
          TripsLoadSuccessEmpty(),
          TripsLoadSuccessActive(trips: [trip1]),
        ],
      );
    });

    test('should remove a trip from the list in response to a DeleteTrip event',
        () {
      when(tripsRepository.trips()).thenAnswer((_) => Stream.value([]));
      tripsBloc
        ..add(LoadTrips())
        ..add(AddTrip(trip: trip1))
        ..add(DeleteTrip(trip: trip1));
      emitsExactly(tripsBloc, [
        TripsLoadInProgress(),
        TripsLoadSuccessEmpty(),
        TripsLoadSuccessActive(trips: [trip1]),
        TripsLoadSuccessEmpty(),
      ]);
    });

    test('should clear all trips in response to  a TripsCleared event', () {
      when(tripsRepository.trips()).thenAnswer((_) => Stream.value([]));
      tripsBloc
        ..add(LoadTrips())
        ..add(AddTrip(trip: updatedTrip1))
        ..add(AddTrip(trip: trip2))
        ..add(TripsCleared());
      emitsExactly(tripsBloc, [
        TripsLoadInProgress(),
        TripsLoadSuccessEmpty(),
        TripsLoadSuccessNotActive(trips: [updatedTrip1]),
        TripsLoadSuccessActive(trips: [updatedTrip1, trip2]),
        TripsLoadSuccessEmpty(),
      ]);
    });
  });
}

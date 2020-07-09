import 'package:covtrack/business/blocs/trip_details/trip_details_bloc.dart';
import 'package:covtrack/business/repositories/location/location_repository.dart';
import 'package:covtrack/business/repositories/places/places_repository.dart';
import 'package:covtrack/data/coordinates.dart';
import 'package:covtrack/data/place.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

class MockPlacesRepository extends Mock implements PlacesRepository {}

void main() {
  group('TripDetailsBloc', () {
    LocationRepository locationRepository;
    PlacesRepository placesRepository;
    TripDetailsBloc tripDetailsBloc;

    setUp(() {
      locationRepository = MockLocationRepository();
      placesRepository = MockPlacesRepository();
      tripDetailsBloc = TripDetailsBloc(
        locationRepository: locationRepository,
        placesRepository: placesRepository,
      );
    });

    tearDown(() {
      tripDetailsBloc?.close();
    });

    test('throws AssertionError if LocationRepository is null', () {
      expect(
        () => TripDetailsBloc(
          locationRepository: null,
          placesRepository: placesRepository,
        ),
        throwsA(isAssertionError),
      );
    });

    test('throws AssertionError if PlacesRepository is null', () {
      expect(
        () => TripDetailsBloc(
          locationRepository: locationRepository,
          placesRepository: null,
        ),
        throwsA(isAssertionError),
      );
    });

    test('initial state is TripsInitial', () {
      expect(tripDetailsBloc.state, TripDetailsInitial());
    });

    test('close does not emit new states', () {
      expectLater(
        tripDetailsBloc,
        emitsInOrder([TripDetailsInitial(), emitsDone]),
      );
      tripDetailsBloc.close();
    });

    group('LoadCurrentPlace', () {
      final Coordinates coords = Coordinates(
        latitude: 44.1234567,
        longitude: 11.1234567,
      );
      final Place place = Place(
        placeId: 'ABCD1234',
        coords: coords,
        formattedAddress: 'via Rossi 1, 40126 Bologna (BO), Italy',
        name: 'via Rossi 1, 40126 Bologna (BO), Italy',
      );

      blocTest(
        'emits [UserPlaceLoading, UserPlaceSuccess] if the user\'s current location is successfully loaded',
        build: () async {
          when(locationRepository.currentLocation).thenAnswer(
            (_) async => coords,
          );
          when(placesRepository.getPlaceFromCoords(
            latitude: coords.latitude,
            longitude: coords.longitude,
          )).thenAnswer(
            (_) async => place,
          );
          return tripDetailsBloc;
        },
        act: (bloc) => bloc.add(LoadCurrentPlace()),
        expect: [
          UserPlaceLoading(),
          UserPlaceSuccess(place),
        ],
      );

      blocTest(
        'emits [UserPlaceLoading, UserPlaceError] if an exception is thrown',
        build: () async {
          when(locationRepository.currentLocation).thenThrow(Exception('oops'));
          return tripDetailsBloc;
        },
        act: (bloc) => bloc.add(LoadCurrentPlace()),
        expect: [
          UserPlaceLoading(),
          UserPlaceError(),
        ],
      );
    });

    group('SelectNewReason', () {
      blocTest(
        'emits [NewReason] when a new reason is selected',
        build: () async => tripDetailsBloc,
        act: (bloc) => bloc.add(SelectNewReason(reason: 'Proven work needs')),
        expect: [NewReason('Proven work needs')],
      );
    });
  });
}

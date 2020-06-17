import 'package:covtrack/business/blocs/trip_details/trip_details_bloc.dart';
import 'package:covtrack/business/repositories/location/location_repository.dart';
import 'package:covtrack/business/repositories/places/places_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

class MockPlacesRepository extends Mock implements PlacesRepository {}

void main() {
  LocationRepository locationRepository;
  PlacesRepository placesRepository;
  TripDetailsBloc tripDetailsBloc;

  group('TripDetailsBloc', () {
    setUp(() {
      locationRepository = MockLocationRepository();
      placesRepository = MockPlacesRepository();
      tripDetailsBloc = TripDetailsBloc(
        locationRepository: locationRepository,
        placesRepository: placesRepository,
      );
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
      expect(tripDetailsBloc.initialState, TripDetailsInitial());
    });
  });
}

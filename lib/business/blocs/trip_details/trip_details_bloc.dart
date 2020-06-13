import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/place.dart';
import '../../repositories/location/location_repository.dart';
import '../../repositories/places/places_repository.dart';

part 'trip_details_event.dart';
part 'trip_details_state.dart';

/// BLoC responsible for the business logic behind the trip details screen. It will determine
/// the starting point of the trip from the current location of the device and it will
/// manage the business logic behind the reason picker. In particular this BLoC will map the
/// incoming [TripDetailsEvent] to the correct [TripDetailsState].
class TripDetailsBloc extends Bloc<TripDetailsEvent, TripDetailsState> {
  /// Location repository used to retrieve user location.
  final LocationRepository locationRepository;

  /// Places repository used to map user's coordinates to a place using Google reverse geocoding APIs.
  final PlacesRepository placesRepository;

  TripDetailsBloc({
    @required this.locationRepository,
    @required this.placesRepository,
  })  : assert(locationRepository != null),
        assert(placesRepository != null);

  @override
  TripDetailsState get initialState => TripDetailsInitial();

  @override
  Stream<TripDetailsState> mapEventToState(TripDetailsEvent event) async* {
    if (event is LoadCurrentPlace) {
      yield* _mapLoadCurrentPlaceToState();
    } else if (event is SelectNewReason) {
      yield* _mapSelectNewReasonToState(event.reason);
    }
  }

  Stream<TripDetailsState> _mapLoadCurrentPlaceToState() async* {
    yield UserPlaceLoading();
    try {
      final currentCoords = await locationRepository.currentLocation;
      final place = await placesRepository.getPlaceFromCoords(
        currentCoords.latitude,
        currentCoords.longitude,
      );
      yield UserPlaceSuccess(place);
    } catch (_) {
      yield UserPlaceError();
    }
  }

  Stream<TripDetailsState> _mapSelectNewReasonToState(String reason) async* {
    yield NewReason(reason);
  }
}

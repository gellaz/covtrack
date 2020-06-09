import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/place.dart';
import '../../repositories/location/location_repository.dart';
import '../../repositories/places/places_repository.dart';

part 'trip_details_event.dart';
part 'trip_details_state.dart';

class TripDetailsBloc extends Bloc<TripDetailsEvent, TripDetailsState> {
  final LocationRepository locationRepository;
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

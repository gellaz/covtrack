import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/trip.dart';
import '../../repositories/trips/trips_repository.dart';

part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final TripsRepository tripsRepository;

  TripsBloc(this.tripsRepository) : assert(tripsRepository != null);

  @override
  TripsState get initialState => TripsInitial();

  @override
  Stream<TripsState> mapEventToState(TripsEvent event) async* {
    yield TripsLoadInProgress();

    if (event is TripsLoaded) {
      yield* _mapTripsLoadedToState();
    } else if (event is TripAdded) {
      yield* _mapTripAddedToState(event.trip);
    } else if (event is TripDeleted) {
      yield* _mapTripDeletedToState(event.trip);
    } else if (event is TripUpdated) {
      yield* _mapTripUpdatedToState(event.trip);
    }
  }

  Stream<TripsState> _mapTripAddedToState(Trip trip) async* {
    try {
      await tripsRepository.insert(trip);
      add(TripsLoaded());
    } catch (e) {
      yield TripsLoadFailure(e.toString());
    }
  }

  Stream<TripsState> _mapTripsLoadedToState() async* {
    try {
      final trips = await tripsRepository.getAllTrips();
      if (trips.isEmpty)
        yield TripsEmpty();
      else
        yield TripsLoadSuccess(trips);
    } catch (e) {
      yield TripsLoadFailure(e.toString());
    }
  }

  Stream<TripsState> _mapTripDeletedToState(Trip trip) async* {
    try {
      await tripsRepository.delete(trip);
      add(TripsLoaded());
    } catch (e) {
      yield TripsLoadFailure(e.toString());
    }
  }

  Stream<TripsState> _mapTripUpdatedToState(Trip trip) async* {
    try {
      await tripsRepository.update(trip);
      add(TripsLoaded());
    } catch (e) {
      yield TripsLoadFailure(e.toString());
    }
  }
}

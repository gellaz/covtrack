import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/trip.dart';
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
    if (event is TripAdded) {
      yield* _mapTripAddedToState(event.trip);
    } else if (event is TripsLoaded) {
      yield* _mapTripsLoadedToState();
    } else if (event is TripDeleted) {
      yield* _mapTripDeletedToState(event.trip);
    }
  }

  Stream<TripsState> _mapTripAddedToState(Trip trip) async* {
    yield TripsLoadInProgress();
    try {
      await tripsRepository.insert(trip);
      final trips = await tripsRepository.getAllTrips();
      yield TripsLoadSuccess(trips);
    } catch (e) {
      yield TripsLoadFailure(e.toString());
    }
  }

  Stream<TripsState> _mapTripsLoadedToState() async* {
    yield TripsLoadInProgress();
    try {
      final trips = await tripsRepository.getAllTrips();
      yield TripsLoadSuccess(trips);
    } catch (e) {
      yield TripsLoadFailure(e.toString());
    }
  }

  Stream<TripsState> _mapTripDeletedToState(Trip trip) async* {
    yield TripsLoadInProgress();
    try {
      await tripsRepository.delete(trip);
      final trips = await tripsRepository.getAllTrips();
      yield TripsLoadSuccess(trips);
    } catch (e) {
      yield TripsLoadFailure(e.toString());
    }
  }
}

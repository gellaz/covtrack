import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/trip.dart';
import '../../repositories/trips/trips_repository.dart';

part 'trips_event.dart';
part 'trips_state.dart';

/// BLoC responsible for the business logic behind trips. It will retrieve, update
/// and delete the trips from the database. In particular this BLoC will map the
/// incoming [TripsEvent] to the correct [TripsState].
class TripsBloc extends Bloc<TripsEvent, TripsState> {
  /// Trips repository used to perform CRUD operations.
  final TripsRepository tripsRepository;

  /// Subscription to trips database changes.
  StreamSubscription _tripsSubscription;

  TripsBloc({@required this.tripsRepository})
      : assert(tripsRepository != null),
        super(TripsInitial());

  @override
  Stream<TripsState> mapEventToState(
    TripsEvent event,
  ) async* {
    yield TripsLoadInProgress();

    if (event is LoadTrips) {
      yield* _mapLoadTripsToState();
    } else if (event is AddTrip) {
      yield* _mapAddTripToState(event);
    } else if (event is UpdateTrip) {
      yield* _mapUpdateTripToState(event);
    } else if (event is DeleteTrip) {
      yield* _mapDeleteTripToState(event);
    } else if (event is TripsCleared) {
      yield* _mapTripsClearedToState();
    } else if (event is TripsUpdated) {
      yield* _mapTripsUpdatedToState(event);
    }
  }

  // Cancels the _tripsSubscription when the TripsBloc is closed.
  @override
  Future<void> close() {
    _tripsSubscription?.cancel();
    return super.close();
  }

  Stream<TripsState> _mapLoadTripsToState() async* {
    _tripsSubscription?.cancel();
    try {
      _tripsSubscription = tripsRepository.trips().listen(
            (List<Trip> trips) => add(TripsUpdated(trips: trips)),
          );
    } catch (_) {
      yield TripsLoadFailure();
    }
  }

  Stream<TripsState> _mapAddTripToState(AddTrip event) async* {
    try {
      tripsRepository.insert(trip: event.trip);
    } catch (_) {
      yield TripsLoadFailure();
    }
  }

  Stream<TripsState> _mapUpdateTripToState(UpdateTrip event) async* {
    try {
      tripsRepository.update(trip: event.trip);
    } catch (_) {
      yield TripsLoadFailure();
    }
  }

  Stream<TripsState> _mapDeleteTripToState(DeleteTrip event) async* {
    try {
      tripsRepository.delete(trip: event.trip);
    } catch (_) {
      yield TripsLoadFailure();
    }
  }

  Stream<TripsState> _mapTripsClearedToState() async* {
    final currentState = state;
    if (currentState is TripsLoadSuccess) {
      List<Trip> trips = currentState.trips;
      try {
        trips.forEach((trip) => tripsRepository.delete(trip: trip));
      } catch (_) {
        yield TripsLoadFailure();
      }
    }
  }

  // When we load our trips, we are subscribing to the TripsRepository
  // and every time a new trip comes in, we add a TripsUpdated event.
  // We then handle all TodosUpdates via the following method.
  Stream<TripsState> _mapTripsUpdatedToState(TripsUpdated event) async* {
    if (event.trips.isEmpty) {
      yield TripsLoadSuccessEmpty();
    } else if (event.trips.last.arrivalTime == null) {
      yield TripsLoadSuccessActive(trips: event.trips);
    } else {
      yield TripsLoadSuccessNotActive(trips: event.trips);
    }
  }
}

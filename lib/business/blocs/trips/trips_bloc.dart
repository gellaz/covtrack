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

  TripsBloc({@required this.tripsRepository}) : assert(tripsRepository != null);

  @override
  TripsState get initialState => TripsInitial();

  @override
  Stream<TripsState> mapEventToState(
    TripsEvent event,
  ) async* {
    if (event is LoadTrips) {
      yield* _mapLoadTripsToState();
    } else if (event is AddTrip) {
      yield* _mapAddTripToState(event);
    } else if (event is UpdateTrip) {
      yield* _mapUpdateTripToState(event);
    } else if (event is DeleteTrip) {
      yield* _mapDeleteTripToState(event);
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
    _tripsSubscription = tripsRepository.trips().listen(
          (List<Trip> trips) => add(TripsUpdated(trips: trips)),
        );
  }

  Stream<TripsState> _mapAddTripToState(AddTrip event) async* {
    tripsRepository.insert(trip: event.trip);
  }

  Stream<TripsState> _mapUpdateTripToState(UpdateTrip event) async* {
    tripsRepository.update(trip: event.trip);
  }

  Stream<TripsState> _mapDeleteTripToState(DeleteTrip event) async* {
    tripsRepository.delete(trip: event.trip);
  }

  // When we load our trips, we are subscribing to the TripsRepository
  // and every time a new trip comes in, we add a TripsUpdated event.
  // We then handle all TodosUpdates via the following method.
  Stream<TripsState> _mapTripsUpdatedToState(TripsUpdated event) async* {
    if (event.trips.isEmpty) {
      yield TripsLoadSuccessEmpty();
    } else if (event.trips.last.arrivalTime == null) {
      yield TripsLoadSuccessActive(event.trips);
    } else {
      yield TripsLoadSuccessNotActive(event.trips);
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/trip.dart';
import '../../repositories/trips/trips_repository.dart';

part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final TripsRepository tripsRepository;

  StreamSubscription _tripsSubscription;

  TripsBloc(this.tripsRepository) : assert(tripsRepository != null);

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
    } else if (event is Clear) {
      yield* _mapClearToState();
    }
  }

  Stream<TripsState> _mapLoadTripsToState() async* {
    _tripsSubscription?.cancel();
    _tripsSubscription = tripsRepository.getAllTrips().listen(
          (trips) => add(TripsUpdated(trips)),
        );
  }

  Stream<TripsState> _mapAddTripToState(AddTrip event) async* {
    tripsRepository.insert(event.trip);
  }

  Stream<TripsState> _mapUpdateTripToState(UpdateTrip event) async* {
    tripsRepository.update(event.trip);
  }

  Stream<TripsState> _mapDeleteTripToState(DeleteTrip event) async* {
    tripsRepository.delete(event.trip);
  }

  Stream<TripsState> _mapTripsUpdatedToState(TripsUpdated event) async* {
    if (event.trips.isEmpty) {
      print('>>>>>>>>>>>>>>>>> EMPTY');
      yield TripsEmpty();
    } else if (event.trips.last.arrivalTime == null) {
      print('>>>>>>>>>>>>>>>>> LAST TRIP: ${event.trips.last}');
      print('>>>>>>>>>>>>>>>>> SUCCESS ACTIVE');
      yield TripsLoadSuccessActive(event.trips);
    } else {
      print('>>>>>>>>>>>>>>>>> LAST TRIP: ${event.trips.last}');
      print('>>>>>>>>>>>>>>>>> SUCCESS NOT ACTIVE');
      yield TripsLoadSuccessNotActive(event.trips);
    }
  }

  Stream<TripsState> _mapClearToState() async* {
    tripsRepository.clear();
  }

  @override
  Future<void> close() {
    _tripsSubscription?.cancel();
    return super.close();
  }
}

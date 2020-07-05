import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/stop.dart';
import '../../repositories/location/location_repository.dart';

part 'stops_tracker_event.dart';
part 'stops_tracker_state.dart';

/// BLoC responsible for the business logic behind the stops tracker. Every time
/// the user stops in a place (moving -> stationary) [Stop] will be added to the
/// list of the stops of the active [Trip]. In particular this BLoC will map the
/// incoming [StopsTrackerEvent] to the correct [StopsTrackerState].
class StopsTrackerBloc extends Bloc<StopsTrackerEvent, StopsTrackerState> {
  /// Location repository used to receive continuous location updates.
  final LocationRepository locationRepository;

  /// List of stops for the active trip.
  final List<Stop> stops;

  /// Subscription to location changes.
  StreamSubscription _locationSubscription;

  StopsTrackerBloc({
    @required this.locationRepository,
    @required this.stops,
  })  : assert(locationRepository != null),
        assert(stops != null),
        super(Ready(stops));

  @override
  Stream<StopsTrackerState> mapEventToState(StopsTrackerEvent event) async* {
    if (event is StartTracking) {
      yield* _mapStartTrackingToState();
    } else if (event is NewStopRecorded) {
      yield* _mapNewStopRecordedToState(event.stop);
    } else if (event is StopTracking) {
      yield* _mapStopTrackingToState();
    }
  }

  // Cancels the _locationSubscription when the StopsTrackerBloc is closed.
  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }

  Stream<StopsTrackerState> _mapStartTrackingToState() async* {
    _locationSubscription?.cancel();
    _locationSubscription =
        locationRepository.locationStream.listen((Stop stop) {
      add(NewStopRecorded(stop: stop));
    });
  }

  Stream<StopsTrackerState> _mapNewStopRecordedToState(Stop stop) async* {
    stops.add(stop);
    yield Running(stops);
  }

  Stream<StopsTrackerState> _mapStopTrackingToState() async* {
    _locationSubscription?.cancel();
    yield Paused(stops);
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/stop.dart';
import '../../repositories/location/location_repository.dart';

part 'stops_tracker_event.dart';
part 'stops_tracker_state.dart';

class StopsTrackerBloc extends Bloc<StopsTrackerEvent, StopsTrackerState> {
  final LocationRepository locationRepository;
  final List<Stop> stops;
  StreamSubscription locationSubscription;

  StopsTrackerBloc({
    @required this.locationRepository,
    @required this.stops,
  })  : assert(locationRepository != null),
        assert(stops != null);

  @override
  StopsTrackerState get initialState => Ready(stops);

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

  /// Cancels the [locationSubscription] when the [StopsTrackerBloc] is closed.
  @override
  Future<void> close() async {
    super.close();
    return await locationSubscription?.cancel();
  }

  Stream<StopsTrackerState> _mapStartTrackingToState() async* {
    await locationSubscription?.cancel();
    locationSubscription =
        locationRepository.locationStream.listen((Stop stop) {
      add(NewStopRecorded(stop));
    });
    yield Running(stops);
  }

  Stream<StopsTrackerState> _mapNewStopRecordedToState(Stop stop) async* {
    stops.add(stop);
    yield Running(stops);
  }

  Stream<StopsTrackerState> _mapStopTrackingToState() async* {
    await locationSubscription?.cancel();
    yield Paused(stops);
  }
}

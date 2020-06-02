import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final Geolocator geolocator;
  int numStops;

  LocationBloc(this.geolocator, this.numStops)
      : assert(geolocator != null),
        assert(numStops != null);

  StreamSubscription locationSubscription;

  @override
  LocationState get initialState => LocationInitial(numStops);

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is LocationStarted) {
      yield* _mapLocationStartedToState();
    } else if (event is LocationChanged) {
      yield* _mapLocationChangedToState(event);
    }
  }

  /// Cancels the [tickerSubscription] when the [TimerBloc] is closed.
  @override
  Future<void> close() {
    locationSubscription?.cancel();
    return super.close();
  }

  Stream<LocationState> _mapLocationStartedToState() async* {
    yield LocationLoadInProgress();

    final geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();

    if (geolocationStatus == GeolocationStatus.granted) {
      locationSubscription?.cancel();

      LocationOptions options = LocationOptions(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
        timeInterval: 0,
      );

      locationSubscription =
          geolocator.getPositionStream(options).listen((Position position) {
        add(LocationChanged(position));
      });
    } else {
      yield LocationLoadFailure('Location Status: $geolocationStatus');
    }
  }

  Stream<LocationState> _mapLocationChangedToState(
    LocationChanged locationChanged,
  ) async* {
    if (locationChanged.position.speed < 1) {
      numStops += 1;
      yield LocationLoadSuccess(locationChanged.position, numStops);
    }
  }
}

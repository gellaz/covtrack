import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covtrack/data/place.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/old_destination.dart';
import '../../repositories/old_destinations/old_destinations_repository.dart';

part 'old_destinations_event.dart';
part 'old_destinations_state.dart';

/// BLoC responsible for the business logic behind old destinations. It will retrieve, update
/// and delete the trips from the database. In particular this BLoC will map the incoming
/// [OldDestinationsEvent] to the correct [OldDestinationsState].
class OldDestinationsBloc
    extends Bloc<OldDestinationsEvent, OldDestinationsState> {
  /// Old destinations repository used to perform CRUD operations.
  final OldDestinationsRepository oldDestinationsRepository;

  /// Subscription to old destinations database changes.
  StreamSubscription _destinationsSubscription;

  OldDestinationsBloc({@required this.oldDestinationsRepository})
      : assert(oldDestinationsRepository != null);

  @override
  OldDestinationsState get initialState => OldDestinationsInitial();

  @override
  Stream<OldDestinationsState> mapEventToState(
    OldDestinationsEvent event,
  ) async* {
    if (event is LoadOldDestinations) {
      yield* _mapLoadOldDestinationsToState();
    } else if (event is SetOldDestination) {
      yield* _mapSetOldDestinationToState(event);
    } else if (event is DeleteOldDestination) {
      yield* _mapDeleteOldDestinationToState(event);
    } else if (event is OldDestinationsUpdated) {
      yield* _mapOldDestinationsUpdatedToState(event);
    } else if (event is OldDestinationsCleared) {
      yield* _mapOldDestinationsClearedToState();
    }
  }

  // Cancels the _destinationsSubscription when the OldDestinationsBloc is closed.
  @override
  Future<void> close() {
    _destinationsSubscription?.cancel();
    return super.close();
  }

  Stream<OldDestinationsState> _mapLoadOldDestinationsToState() async* {
    _destinationsSubscription?.cancel();
    _destinationsSubscription = oldDestinationsRepository.destinations().listen(
          (List<OldDestination> oldDestinations) =>
              add(OldDestinationsUpdated(oldDestinations: oldDestinations)),
        );
  }

  Stream<OldDestinationsState> _mapSetOldDestinationToState(
    SetOldDestination event,
  ) async* {
    oldDestinationsRepository.incrementNumVisits(
      destination: event.destination,
    );
  }

  Stream<OldDestinationsState> _mapDeleteOldDestinationToState(
    DeleteOldDestination event,
  ) async* {
    oldDestinationsRepository.deleteDestination(
      destination: event.destination,
    );
  }

  Stream<OldDestinationsState> _mapOldDestinationsClearedToState() async* {
    final currentState = state;
    if (currentState is OldDestinationsLoadSuccess) {
      List<OldDestination> oldDestinations = currentState.oldDestinations;
      oldDestinations.forEach((oldDestination) => oldDestinationsRepository
          .deleteDestination(destination: oldDestination.place));
    }
  }

  // When we load our destinations, we are subscribing to the OldDestinationsRepository
  // and every time a new trip comes in, we add a OldDestinationsUpdated event.
  // We then handle all TodosUpdates via the following method.
  Stream<OldDestinationsState> _mapOldDestinationsUpdatedToState(
    OldDestinationsUpdated event,
  ) async* {
    if (event.oldDestinations.isEmpty) {
      yield OldDestinationsLoadSuccessEmpty();
    } else {
      yield OldDestinationsLoadSuccess(oldDestinations: event.oldDestinations);
    }
  }
}

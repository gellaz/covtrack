part of 'old_destinations_bloc.dart';

/// The [OldDestinationsBloc] will need to know how to process the following events:
/// [LoadOldDestinations] - informs the [OldDestinationsBloc] to load the list of all user's old destinations.
/// [SetOldDestination] - informs the [OldDestinationsBloc] to add a old destination to the list of user's old
/// destinations if not present yet otherwise to update the number of visits for that destination.
/// [DeleteOldDestination] -  informs the [OldDestinationsBloc] that an old destination has been deleted.
/// [ClearCompleted] - informs the [OldDestinationsBloc] the all user's old destinations should be deleted.
/// [OldDestinationsUpdated] - event that groups all the previous events.
abstract class OldDestinationsEvent extends Equatable {
  const OldDestinationsEvent();

  @override
  List<Object> get props => [];
}

class LoadOldDestinations extends OldDestinationsEvent {}

class SetOldDestination extends OldDestinationsEvent {
  final Place destination;

  const SetOldDestination({@required this.destination});

  @override
  List<Object> get props => [destination];

  @override
  String toString() => 'SetOldDestination { destination: $destination }';
}

class DeleteOldDestination extends OldDestinationsEvent {
  final OldDestination oldDestination;

  const DeleteOldDestination({@required this.oldDestination});

  @override
  List<Object> get props => [oldDestination];

  @override
  String toString() =>
      'DeleteOldDestination { oldDestination: $oldDestination }';
}

class OldDestinationsUpdated extends OldDestinationsEvent {
  final List<OldDestination> oldDestinations;

  const OldDestinationsUpdated({@required this.oldDestinations});

  @override
  List<Object> get props => [oldDestinations];

  @override
  String toString() =>
      'OldDestinationsUpdated { oldDestinations: $oldDestinations }';
}

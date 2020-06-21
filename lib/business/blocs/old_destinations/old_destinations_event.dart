part of 'old_destinations_bloc.dart';

/// The [OldDestinationsBloc] will need to know how to process the following events:
/// [LoadOldDestinations] - informs the [OldDestinationsBloc] to load the list of all user's old destinations.
/// [OldDestinationsUpdated] - informs the [OldDestinationsBloc] that the loaded list containing user's old destinations has been updated.
abstract class OldDestinationsEvent extends Equatable {
  const OldDestinationsEvent();

  @override
  List<Object> get props => [];
}

class LoadOldDestinations extends OldDestinationsEvent {}

class OldDestinationsUpdated extends OldDestinationsEvent {
  final List<OldDestination> oldDestinations;

  const OldDestinationsUpdated({@required this.oldDestinations});

  @override
  List<Object> get props => [oldDestinations];

  @override
  String toString() =>
      'OldDestinationsUpdated { oldDestinations: $oldDestinations }';
}

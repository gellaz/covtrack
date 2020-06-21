part of 'old_destinations_bloc.dart';

/// The [OldDestinationsBloc] state can be one of the following:
/// [OldDestinationsInitial] - ready to fetch old destinations data.
/// [OldDestinationsLoadInProgress] - loading old destinations data.
/// [OldDestinationsLoadSuccess] - abstract state for old destinations data loaded successfully.
/// [OldDestinationsLoadSuccessEmpty] - the list of old destinations loaded is empty.
/// [OldDestinationsLoadFailure] - an error has occurred while loading old destinations data.
abstract class OldDestinationsState extends Equatable {
  const OldDestinationsState();

  @override
  List<Object> get props => [];
}

class OldDestinationsInitial extends OldDestinationsState {}

class OldDestinationsLoadInProgress extends OldDestinationsState {}

class OldDestinationsLoadSuccess extends OldDestinationsState {
  final List<OldDestination> oldDestinations;

  const OldDestinationsLoadSuccess({this.oldDestinations});

  @override
  List<Object> get props => [oldDestinations];

  @override
  String toString() =>
      'OldDestinationsLoadSuccess { oldDestinations: $oldDestinations }';
}

class OldDestinationsLoadSuccessEmpty extends OldDestinationsState {}

class OldDestinationsLoadFailure extends OldDestinationsState {}

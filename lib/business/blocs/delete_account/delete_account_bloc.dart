import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/validators.dart';
import '../../repositories/authentication/authentication_repository.dart';
import '../../repositories/old_destinations/old_destinations_repository.dart';
import '../../repositories/trips/trips_repository.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

/// BLoC responsible for the business logic behind the account deletion process. In particular
/// this BLoC will map the incoming [DeleteAccountEvent] to the correct [DeleteAccountState].
class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  /// Authentication repository used to delete the account.
  final AuthenticationRepository authRepository;

  /// Trips repository used to clear all the stored trips of the user from the database.
  final TripsRepository tripsRepository;

  /// Old destinations repository used to clear all the reached destinations of the user stored in the database.
  final OldDestinationsRepository oldDestinationsRepository;

  DeleteAccountBloc({
    @required this.authRepository,
    @required this.tripsRepository,
    @required this.oldDestinationsRepository,
  })  : assert(authRepository != null),
        assert(tripsRepository != null),
        assert(oldDestinationsRepository != null);

  @override
  DeleteAccountState get initialState => DeleteAccountState.empty();

  // Overriding transformEvents in order to debounce the PasswordChanged event
  // so that we give the user some time to stop typing before validating the input.
  @override
  Stream<Transition<DeleteAccountEvent, DeleteAccountState>> transformEvents(
    Stream<DeleteAccountEvent> events,
    TransitionFunction<DeleteAccountEvent, DeleteAccountState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<DeleteAccountState> mapEventToState(
    DeleteAccountEvent event,
  ) async* {
    if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.password);
    }
  }

  Stream<DeleteAccountState> _mapPasswordChangedToState(
    String password,
  ) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<DeleteAccountState> _mapFormSubmittedToState(
    String password,
  ) async* {
    yield DeleteAccountState.loading();
    try {
      // Deletes all the trips stored in the database for that user.
      await tripsRepository.clear();
      // Deletes all the reached destinations stored in the database for that user.
      await oldDestinationsRepository.clear();
      // Deletes user account.
      await authRepository.deleteAccount(password: password);
      yield DeleteAccountState.success();
    } catch (e) {
      yield DeleteAccountState.failure();
    }
  }
}

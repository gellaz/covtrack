import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/validators.dart';
import '../../repositories/authentication/authentication_repository.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

/// BLoC responsible for the business logic behind the account deletion process. In particular
/// this BLoC will map the incoming [DeleteAccountEvent] to the correct [DeleteAccountState].
class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  /// Authentication repository used to delete the account.
  final AuthenticationRepository authRepository;

  DeleteAccountBloc({@required this.authRepository})
      : assert(authRepository != null);

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
      await authRepository.deleteAccount(password: password);
      yield DeleteAccountState.success();
    } catch (e) {
      yield DeleteAccountState.failure();
    }
  }
}

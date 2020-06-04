import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/validators.dart';
import '../../repositories/authentication/authentication_repository.dart';

part 'password_change_event.dart';
part 'password_change_state.dart';

/// BLoC that is going to manage the checking and updating a user's [PasswordChangeState] in response to [PasswordChangeEvents].
class PasswordChangeBloc
    extends Bloc<PasswordChangeEvent, PasswordChangeState> {
  final AuthenticationRepository authRepository;

  PasswordChangeBloc(this.authRepository) : assert(authRepository != null);

  @override
  PasswordChangeState get initialState => PasswordChangeState.empty();

  // Overriding transformEvents in order to debounce the OldPasswordChanged, NewPasswordChanged and NewPasswordCheckChanged
  // events so that we give the user some time to stop typing before validating the input.
  @override
  Stream<Transition<PasswordChangeEvent, PasswordChangeState>> transformEvents(
    Stream<PasswordChangeEvent> events,
    TransitionFunction<PasswordChangeEvent, PasswordChangeState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! OldPasswordChanged &&
          event is! NewPasswordChanged &&
          event is! NewPasswordCheckChanged);
    });
    final debounceStream = events.where((event) {
      return (event is OldPasswordChanged ||
          event is NewPasswordChanged ||
          event is NewPasswordCheckChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<PasswordChangeState> mapEventToState(
    PasswordChangeEvent event,
  ) async* {
    if (event is OldPasswordChanged) {
      yield* _mapOldPasswordChangedToState(event.password);
    } else if (event is NewPasswordChanged) {
      yield* _mapNewPasswordChangedToState(event.password);
    } else if (event is NewPasswordCheckChanged) {
      yield* _mapNewPasswordCheckChangedToState(
        event.password,
        event.passwordCheck,
      );
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.oldPassword, event.newPassowrd);
    }
  }

  Stream<PasswordChangeState> _mapOldPasswordChangedToState(
    String password,
  ) async* {
    yield state.update(
      isOldPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<PasswordChangeState> _mapNewPasswordChangedToState(
    String password,
  ) async* {
    yield state.update(
      isNewPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<PasswordChangeState> _mapNewPasswordCheckChangedToState(
    String password,
    String passwordCheck,
  ) async* {
    yield state.update(
      isNewPasswordCheckValid: password == passwordCheck,
    );
  }

  Stream<PasswordChangeState> _mapFormSubmittedToState(
    String oldPassword,
    String newPassword,
  ) async* {
    yield PasswordChangeState.loading();
    try {
      await authRepository.changePassword(oldPassword, newPassword);

      yield PasswordChangeState.success();
    } catch (_) {
      yield PasswordChangeState.failure();
    }
  }
}

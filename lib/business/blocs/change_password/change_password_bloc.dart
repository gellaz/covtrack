import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/validators.dart';
import '../../repositories/authentication/authentication_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

/// BLoC that is going to manage the checking and updating a user's [ChangePasswordState] in response to [ChangePasswordEvents].
class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  /// Authentication repository used to change the password of the account.
  final AuthenticationRepository authRepository;

  ChangePasswordBloc({
    @required this.authRepository,
  }) : assert(authRepository != null);

  @override
  ChangePasswordState get initialState => ChangePasswordState.empty();

  // Overriding transformEvents in order to debounce the OldPasswordChanged, NewPasswordChanged and NewPasswordCheckChanged
  // events so that we give the user some time to stop typing before validating the input.
  @override
  Stream<Transition<ChangePasswordEvent, ChangePasswordState>> transformEvents(
    Stream<ChangePasswordEvent> events,
    TransitionFunction<ChangePasswordEvent, ChangePasswordState> transitionFn,
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
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if (event is OldPasswordChanged) {
      yield* _mapOldPasswordChangedToState(event.password);
    } else if (event is NewPasswordChanged) {
      yield* _mapNewPasswordChangedToState(event.password, event.passwordCheck);
    } else if (event is NewPasswordCheckChanged) {
      yield* _mapNewPasswordCheckChangedToState(
        event.password,
        event.passwordCheck,
      );
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.currentPassword, event.newPassowrd);
    }
  }

  Stream<ChangePasswordState> _mapOldPasswordChangedToState(
    String password,
  ) async* {
    yield state.update(
      isOldPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<ChangePasswordState> _mapNewPasswordChangedToState(
    String password,
    String passwordCheck,
  ) async* {
    yield state.update(
      isNewPasswordValid: Validators.isValidPassword(password),
      isNewPasswordCheckValid: password == passwordCheck,
    );
  }

  Stream<ChangePasswordState> _mapNewPasswordCheckChangedToState(
    String password,
    String passwordCheck,
  ) async* {
    yield state.update(
      isNewPasswordCheckValid: password == passwordCheck,
    );
  }

  Stream<ChangePasswordState> _mapFormSubmittedToState(
    String currentPassword,
    String newPassword,
  ) async* {
    yield ChangePasswordState.loading();
    try {
      await authRepository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      yield ChangePasswordState.success();
    } catch (_) {
      yield ChangePasswordState.failure();
    }
  }
}

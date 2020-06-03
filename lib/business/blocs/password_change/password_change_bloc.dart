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

  // Overriding transformEvents in order to debounce the PasswordChanged and PasswordCheckChanged
  // events so that we give the user some time to stop typing before validating the input.
  @override
  Stream<Transition<PasswordChangeEvent, PasswordChangeState>> transformEvents(
    Stream<PasswordChangeEvent> events,
    TransitionFunction<PasswordChangeEvent, PasswordChangeState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! PasswordChanged && event is! PasswordCheckChanged);
    });
    final debounceStream = events.where((event) {
      return (event is PasswordChanged || event is PasswordCheckChanged);
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
    if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is PasswordCheckChanged) {
      yield* _mapPasswordCheckChangedToState(
        event.password,
        event.passwordCheck,
      );
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.password);
    }
  }

  Stream<PasswordChangeState> _mapPasswordChangedToState(
    String password,
  ) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<PasswordChangeState> _mapPasswordCheckChangedToState(
    String password,
    String passwordCheck,
  ) async* {
    yield state.update(
      isPasswordCheckValid: password == passwordCheck,
    );
  }

  Stream<PasswordChangeState> _mapFormSubmittedToState(
    String password,
  ) async* {
    yield PasswordChangeState.loading();
    try {
      final res = await authRepository.changePassword(password);
      print('>>> $res');
      yield PasswordChangeState.success();
    } catch (e) {
      yield PasswordChangeState.failure();
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/validators.dart';
import '../../repositories/authentication/authentication_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

/// BLoC responsible for the business logic behind the registration process. In particular
/// this BLoC will map the incoming [RegisterEvent] to the correct [RegisterState].
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  /// Authentication repository used to sign-up the user.
  final AuthenticationRepository authRepository;

  RegisterBloc({@required this.authRepository})
      : assert(authRepository != null);

  @override
  RegisterState get initialState => RegisterState.empty();

  // Overriding transformEvents in order to debounce the EmailChanged, PasswordChanged and PasswordCheckChanged
  // events so that we give the user some time to stop typing before validating the input.
  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
    Stream<RegisterEvent> events,
    TransitionFunction<RegisterEvent, RegisterState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged &&
          event is! PasswordChanged &&
          event is! PasswordCheckChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged ||
          event is PasswordChanged ||
          event is PasswordCheckChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is PasswordCheckChanged) {
      yield* _mapPasswordCheckChangedToState(
        event.password,
        event.passwordCheck,
      );
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapPasswordCheckChangedToState(
    String password,
    String passwordCheck,
  ) async* {
    yield state.update(
      isPasswordCheckValid: password == passwordCheck,
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String email,
    String password,
  ) async* {
    yield RegisterState.loading();
    try {
      await authRepository.signUp(
        email: email,
        password: password,
      );
      yield RegisterState.success();
    } catch (e) {
      yield RegisterState.failure();
    }
  }
}

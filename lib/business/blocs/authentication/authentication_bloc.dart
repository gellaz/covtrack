import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/user.dart';
import '../../repositories/authentication/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// BLoC responsible for the business logic behind the authentication process. In particular this BLoC will
/// map the incoming [AuthenticationEvent] to the correct [AuthenticationState].
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// Authentication repository used to check if the user is currently signed in,
  /// to get the user and to sign out the user.
  final AuthenticationRepository authRepository;

  AuthenticationBloc({@required this.authRepository})
      : assert(authRepository != null),
        super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final isSignedIn = await authRepository.isSignedIn();
    if (isSignedIn) {
      final user = await authRepository.getUser();
      yield Authenticated(user);
    } else {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await authRepository.getUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    authRepository.signOut();
  }
}

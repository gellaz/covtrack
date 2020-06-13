part of 'authentication_bloc.dart';

/// List of [AuthenticationEvent] objects to which our [AuthenticationBloc] will be reacting to:
/// [AppStarted] - notifies the [AuthenticationBloc] that it needs to check if the user is currently authenticated or not.
/// [LoggedIn] - notifies the [AuthenticationBloc] that the user has successfully logged in.
/// [LoggedOut] - notifies the [AuthenticationBloc] that the user has successfully logged out.
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}

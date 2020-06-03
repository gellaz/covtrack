part of 'authentication_bloc.dart';

/// A user's authentication state can be one of the following:
/// [Uninitialized] - waiting to see if the user is authenticated or not on app start
/// [Authenticated] - successfully authenticated
/// [Unauthenticated] - not authenticated
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String email;

  const Authenticated(this.email);

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'Authenticated { email: $email }';
}

class Unauthenticated extends AuthenticationState {}

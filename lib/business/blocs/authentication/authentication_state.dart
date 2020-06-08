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
  final FirebaseUser user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated { user: $user }';
}

class Unauthenticated extends AuthenticationState {}

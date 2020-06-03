part of 'password_change_bloc.dart';

abstract class PasswordChangeEvent extends Equatable {
  const PasswordChangeEvent();

  @override
  List<Object> get props => [];
}

class PasswordChanged extends PasswordChangeEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class PasswordCheckChanged extends PasswordChangeEvent {
  final String password;
  final String passwordCheck;

  const PasswordCheckChanged({
    @required this.password,
    @required this.passwordCheck,
  });

  @override
  List<Object> get props => [password, passwordCheck];

  @override
  String toString() =>
      'PasswordCheckChanged { password:$password, passwordCheck: $passwordCheck }';
}

class Submitted extends PasswordCheckChanged {
  final String password;

  const Submitted({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() {
    return 'Submitted { password: $password }';
  }
}

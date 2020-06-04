part of 'password_change_bloc.dart';

abstract class PasswordChangeEvent extends Equatable {
  const PasswordChangeEvent();

  @override
  List<Object> get props => [];
}

class OldPasswordChanged extends PasswordChangeEvent {
  final String password;

  const OldPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'OldPasswordChanged { password: $password }';
}

class NewPasswordChanged extends PasswordChangeEvent {
  final String password;

  const NewPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'NewPasswordChanged { password: $password }';
}

class NewPasswordCheckChanged extends PasswordChangeEvent {
  final String password;
  final String passwordCheck;

  const NewPasswordCheckChanged({
    @required this.password,
    @required this.passwordCheck,
  });

  @override
  List<Object> get props => [password, passwordCheck];

  @override
  String toString() =>
      'NewPasswordCheckChanged { password:$password, passwordCheck: $passwordCheck }';
}

class Submitted extends PasswordChangeEvent {
  final String oldPassword;
  final String newPassowrd;

  const Submitted({
    @required this.oldPassword,
    @required this.newPassowrd,
  });

  @override
  List<Object> get props => [oldPassword, newPassowrd];

  @override
  String toString() =>
      'Submitted { oldPassword: $oldPassword, newPassword: $newPassowrd }';
}

part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class OldPasswordChanged extends ChangePasswordEvent {
  final String password;

  const OldPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'OldPasswordChanged { password: $password }';
}

class NewPasswordChanged extends ChangePasswordEvent {
  final String password;
  final String passwordCheck;

  const NewPasswordChanged({
    @required this.password,
    @required this.passwordCheck,
  });

  @override
  List<Object> get props => [password, passwordCheck];

  @override
  String toString() =>
      'NewPasswordChanged { password: $password, passwordCheck: $passwordCheck }';
}

class NewPasswordCheckChanged extends ChangePasswordEvent {
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

class Submitted extends ChangePasswordEvent {
  final String currentPassword;
  final String newPassowrd;

  const Submitted({
    @required this.currentPassword,
    @required this.newPassowrd,
  });

  @override
  List<Object> get props => [currentPassword, newPassowrd];

  @override
  String toString() =>
      'Submitted { currentPassword: $currentPassword, newPassword: $newPassowrd }';
}

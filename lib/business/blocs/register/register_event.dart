part of 'register_bloc.dart';

/// List of [RegisterEvent] objects to which our [RegisterBloc] will be reacting to:
/// [EmailChanged] - notifies the BLoC that the user has changed the email
/// [PasswordChanged] - notifies the BLoC that the user has changed the password
/// [PasswordCheckChanged] - notifies the BLoC that the user has changed the password verification
/// [Submitted] - notifies the BLoC that the user has submitted the form
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class PasswordCheckChanged extends RegisterEvent {
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

class Submitted extends RegisterEvent {
  final String email;
  final String password;

  const Submitted({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}

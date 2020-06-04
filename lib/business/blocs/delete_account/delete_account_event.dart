part of 'delete_account_bloc.dart';

/// List of [DeleteAccountEvent] objects to which our [DeleteAccountBloc] will be reacting to:
/// [PasswordChanged] - notifies the BLoC that the user has changed the email
/// [Submitted] - notifies the BLoC that the user has submitted the form
abstract class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();

  @override
  List<Object> get props => [];
}

class PasswordChanged extends DeleteAccountEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends DeleteAccountEvent {
  final String password;

  const Submitted({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'Submitted { password: $password }';
}

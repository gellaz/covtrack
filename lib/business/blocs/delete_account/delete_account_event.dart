part of 'delete_account_bloc.dart';

/// List of [DeleteAccountEvent] objects to which our [DeleteAccountBloc] will be reacting to:
/// [PasswordChanged] - notifies the BLoC that the user has changed the email
/// [Submitted] - notifies the BLoC that the user has submitted the form
abstract class DeleteAccountEvent extends Equatable {
  final String password;

  const DeleteAccountEvent(this.password);

  @override
  List<Object> get props => [password];
}

class PasswordChanged extends DeleteAccountEvent {
  const PasswordChanged({@required String password}) : super(password);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends DeleteAccountEvent {
  const Submitted({@required String password}) : super(password);

  @override
  String toString() => 'Submitted { password: $password }';
}

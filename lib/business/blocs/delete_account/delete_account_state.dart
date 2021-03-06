part of 'delete_account_bloc.dart';

/// Here is a list of the possible [DeleteAccountState] in which the [DeleteAccountForm] can be:
/// [empty] - initial state of the [DeleteAccountForm]
/// [loading] - state of the [DeleteAccountForm] when we are validating the inserted password
/// [failure] - state of the [DeleteAccountForm] when a delete account attempt has failed
/// [success] - state of the [DeleteAccountForm] when a delete account attempt has succeeded
class DeleteAccountState extends Equatable {
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const DeleteAccountState({
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory DeleteAccountState.empty() {
    return DeleteAccountState(
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory DeleteAccountState.loading() {
    return DeleteAccountState(
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory DeleteAccountState.failure() {
    return DeleteAccountState(
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory DeleteAccountState.success() {
    return DeleteAccountState(
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  DeleteAccountState update({
    bool isPasswordValid,
  }) {
    return copyWith(
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  DeleteAccountState copyWith({
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return DeleteAccountState(
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object> get props => [
        isPasswordValid,
        isSubmitting,
        isSuccess,
        isFailure,
      ];

  @override
  String toString() {
    return '''
    DeleteAccountState {
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}

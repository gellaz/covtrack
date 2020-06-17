part of 'change_password_bloc.dart';

/// Here is a list of the possible [RegisterState] in which the [RegisterForm] can be:
/// [empty] - initial state of the [RegisterForm]
/// [loading] - state of the [RegisterForm] when we are validating credentials
/// [failure] - state of the [RegisterForm] when a login attempt has failed
/// [success] - state of the [RegisterForm] when a login attempt has succeeded
class ChangePasswordState extends Equatable {
  final bool isOldPasswordValid;
  final bool isNewPasswordValid;
  final bool isNewPasswordCheckValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isOldPasswordValid && isNewPasswordValid && isNewPasswordCheckValid;

  const ChangePasswordState({
    @required this.isOldPasswordValid,
    @required this.isNewPasswordValid,
    @required this.isNewPasswordCheckValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory ChangePasswordState.empty() {
    return ChangePasswordState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isNewPasswordCheckValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ChangePasswordState.loading() {
    return ChangePasswordState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isNewPasswordCheckValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ChangePasswordState.failure() {
    return ChangePasswordState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isNewPasswordCheckValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory ChangePasswordState.success() {
    return ChangePasswordState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isNewPasswordCheckValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  ChangePasswordState update({
    bool isOldPasswordValid,
    bool isNewPasswordValid,
    bool isNewPasswordCheckValid,
  }) {
    return copyWith(
      isOldPasswordValid: isOldPasswordValid,
      isNewPasswordValid: isNewPasswordValid,
      isNewPasswordCheckValid: isNewPasswordCheckValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  ChangePasswordState copyWith({
    bool isOldPasswordValid,
    bool isNewPasswordValid,
    bool isNewPasswordCheckValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return ChangePasswordState(
      isOldPasswordValid: isOldPasswordValid ?? this.isOldPasswordValid,
      isNewPasswordValid: isNewPasswordValid ?? this.isNewPasswordValid,
      isNewPasswordCheckValid:
          isNewPasswordCheckValid ?? this.isNewPasswordCheckValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object> get props => [
        isOldPasswordValid,
        isNewPasswordValid,
        isNewPasswordCheckValid,
        isSubmitting,
        isSuccess,
        isFailure,
      ];

  @override
  String toString() {
    return '''
    ChangePasswordState {
      isOldPasswordValid: $isOldPasswordValid,
      isNewPasswordValid: $isNewPasswordValid,
      isNewPasswordCheckValid: $isNewPasswordCheckValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}

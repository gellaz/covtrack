part of 'password_change_bloc.dart';

@immutable
class PasswordChangeState {
  final bool isOldPasswordValid;
  final bool isNewPasswordValid;
  final bool isNewPasswordCheckValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isOldPasswordValid && isNewPasswordValid && isNewPasswordCheckValid;

  PasswordChangeState({
    @required this.isOldPasswordValid,
    @required this.isNewPasswordValid,
    @required this.isNewPasswordCheckValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory PasswordChangeState.empty() {
    return PasswordChangeState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isNewPasswordCheckValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory PasswordChangeState.loading() {
    return PasswordChangeState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isNewPasswordCheckValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory PasswordChangeState.failure() {
    return PasswordChangeState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isNewPasswordCheckValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory PasswordChangeState.success() {
    return PasswordChangeState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isNewPasswordCheckValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  PasswordChangeState update({
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

  PasswordChangeState copyWith({
    bool isOldPasswordValid,
    bool isNewPasswordValid,
    bool isNewPasswordCheckValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return PasswordChangeState(
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
  String toString() {
    return '''
    PasswordChangeState {
      isOldPasswordValid: $isOldPasswordValid,
      isNewPasswordValid: $isNewPasswordValid,
      isNewPasswordCheckValid: $isNewPasswordCheckValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}

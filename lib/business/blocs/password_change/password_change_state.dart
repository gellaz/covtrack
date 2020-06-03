part of 'password_change_bloc.dart';

@immutable
class PasswordChangeState {
  final bool isPasswordValid;
  final bool isPasswordCheckValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isPasswordValid && isPasswordCheckValid;

  PasswordChangeState({
    @required this.isPasswordValid,
    @required this.isPasswordCheckValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory PasswordChangeState.empty() {
    return PasswordChangeState(
      isPasswordValid: true,
      isPasswordCheckValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory PasswordChangeState.loading() {
    return PasswordChangeState(
      isPasswordValid: true,
      isPasswordCheckValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory PasswordChangeState.failure() {
    return PasswordChangeState(
      isPasswordValid: true,
      isPasswordCheckValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory PasswordChangeState.success() {
    return PasswordChangeState(
      isPasswordValid: true,
      isPasswordCheckValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  PasswordChangeState update({
    bool isPasswordValid,
    bool isPasswordCheckValid,
  }) {
    return copyWith(
      isPasswordValid: isPasswordValid,
      isPasswordCheckValid: isPasswordCheckValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  PasswordChangeState copyWith({
    bool isPasswordValid,
    bool isPasswordCheckValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return PasswordChangeState(
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isPasswordCheckValid: isPasswordCheckValid ?? this.isPasswordCheckValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''
    PasswordChangeState {
      isPasswordValid: $isPasswordValid,
      isPasswordCheckValid: $isPasswordCheckValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}

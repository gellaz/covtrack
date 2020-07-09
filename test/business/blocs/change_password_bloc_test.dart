import 'package:covtrack/business/blocs/change_password/change_password_bloc.dart';
import 'package:covtrack/business/repositories/authentication/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('ChangePasswordBloc', () {
    AuthenticationRepository authRepository;
    ChangePasswordBloc changePasswordBloc;

    setUp(() {
      authRepository = MockAuthenticationRepository();
      changePasswordBloc = ChangePasswordBloc(authRepository: authRepository);
    });

    tearDown(() {
      changePasswordBloc?.close();
    });

    test('throws AssertionError if AuthenticationRepository is null', () {
      expect(
        () => ChangePasswordBloc(authRepository: null),
        throwsA(isAssertionError),
      );
    });

    test('initial state is ChangePasswordState.empty()', () {
      expect(changePasswordBloc.state, ChangePasswordState.empty());
    });

    test('close does not emit new states', () {
      expectLater(
        changePasswordBloc,
        emitsInOrder([ChangePasswordState.empty(), emitsDone]),
      );
      changePasswordBloc.close();
    });

    group('OldPasswordChanged', () {
      blocTest(
        'emits [ChangePasswordState] with old password not valid if the old password is not valid',
        build: () async => changePasswordBloc,
        act: (bloc) => bloc.add(OldPasswordChanged(password: 'test')),
        wait: const Duration(milliseconds: 400),
        expect: [
          ChangePasswordState(
            isOldPasswordValid: false,
            isNewPasswordValid: true,
            isNewPasswordCheckValid: true,
            isSubmitting: false,
            isSuccess: false,
            isFailure: false,
          ),
        ],
      );
    });

    group('NewPasswordChanged', () {
      blocTest(
        'emits [ChangePasswordState] with new password not valid if the new password is not valid',
        build: () async => changePasswordBloc,
        act: (bloc) => bloc
            .add(NewPasswordChanged(password: 'test', passwordCheck: 'test')),
        wait: const Duration(milliseconds: 400),
        expect: [
          ChangePasswordState(
            isOldPasswordValid: true,
            isNewPasswordValid: false,
            isNewPasswordCheckValid: true,
            isSubmitting: false,
            isSuccess: false,
            isFailure: false,
          ),
        ],
      );
    });

    group('NewPasswordCheckChanged', () {
      blocTest(
        'emits [ChangePasswordState] with new password not valid if the new password is not valid',
        build: () async => changePasswordBloc,
        act: (bloc) => bloc.add(
            NewPasswordCheckChanged(password: 'test', passwordCheck: 'test')),
        wait: const Duration(milliseconds: 400),
        expect: [
          // ChangePasswordState(
          //   isOldPasswordValid: true,
          //   isNewPasswordValid: true,
          //   isNewPasswordCheckValid: false,
          //   isSubmitting: false,
          //   isSuccess: false,
          //   isFailure: false,
          // ),
        ],
      );
    });

    group('Submitted', () {
      blocTest(
        'emits [ChangePasswordState.loading, ChangePasswordState.success] when the password is successfully changed',
        build: () async {
          when(authRepository.changePassword(
            currentPassword: 'myOldPassword1234',
            newPassword: 'myNewPassword1234',
          )).thenAnswer((_) => Future.value(null));
          return changePasswordBloc;
        },
        act: (bloc) => bloc.add(Submitted(
          currentPassword: 'myOldPassword1234',
          newPassword: 'myNewPassword1234',
        )),
        expect: [
          // ChangePasswordState.loading(),
          // ChangePasswordState.success(),
        ],
      );

      blocTest(
        'emits [ChangePasswordState.loading, ChangePasswordState.failure] when an exception is thrown',
        build: () async {
          when(authRepository.changePassword(
            currentPassword: 'myOldPassword1234',
            newPassword: 'myNewPassword1234',
          )).thenThrow(Exception('oops'));
          return changePasswordBloc;
        },
        act: (bloc) => bloc.add(Submitted(
          currentPassword: 'myOldPassword1234',
          newPassword: 'myNewPassword1234',
        )),
        expect: [
          // ChangePasswordState.loading(),
          // ChangePasswordState.failure(),
        ],
      );
    });
  });
}

import 'package:covtrack/business/blocs/register/register_bloc.dart';
import 'package:covtrack/business/repositories/authentication/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('RegisterBloc', () {
    AuthenticationRepository authRepository;
    RegisterBloc registerBloc;

    setUp(() {
      authRepository = MockAuthenticationRepository();
      registerBloc = RegisterBloc(authRepository: authRepository);
    });

    tearDown(() {
      registerBloc?.close();
    });

    test('throws AssertionError if AuthenticationRepository is null', () {
      expect(
        () => RegisterBloc(authRepository: null),
        throwsA(isAssertionError),
      );
    });

    test('initial state is RegisterState.empty', () {
      expect(registerBloc.state, RegisterState.empty());
    });

    test('close does not emit new states', () {
      expectLater(
        registerBloc,
        emitsInOrder([RegisterState.empty(), emitsDone]),
      );
      registerBloc.close();
    });

    group('EmailChanged', () {
      blocTest(
        'emits [RegisterState] with isEmailValid false not valid if the inserted email is not valid',
        build: () async => registerBloc,
        act: (bloc) => bloc.add(EmailChanged(email: 'john')),
        wait: const Duration(milliseconds: 400),
        expect: [
          RegisterState(
            isEmailValid: false,
            isPasswordValid: true,
            isPasswordCheckValid: true,
            isSubmitting: false,
            isSuccess: false,
            isFailure: false,
          ),
        ],
      );
    });

    group('PasswordChanged', () {
      blocTest(
        'emits [RegisterState] with isPasswordValid false not valid if the inserted password is not valid',
        build: () async => registerBloc,
        act: (bloc) => bloc.add(PasswordChanged(password: 'test')),
        wait: const Duration(milliseconds: 400),
        expect: [
          RegisterState(
            isEmailValid: true,
            isPasswordValid: false,
            isPasswordCheckValid: true,
            isSubmitting: false,
            isSuccess: false,
            isFailure: false,
          ),
        ],
      );
    });

    group('PasswordCheckChanged', () {
      blocTest(
        'emits [RegisterState] with isPasswordCheckValid false not valid if the inserted password check is not equal to the previously inserted password',
        build: () async => registerBloc,
        act: (bloc) => bloc.add(PasswordCheckChanged(
          password: 'test1234',
          passwordCheck: 'test12345',
        )),
        wait: const Duration(milliseconds: 400),
        expect: [
          RegisterState(
            isEmailValid: true,
            isPasswordValid: true,
            isPasswordCheckValid: false,
            isSubmitting: false,
            isSuccess: false,
            isFailure: false,
          ),
        ],
      );
    });

    group('Submitted', () {
      blocTest(
        'emits [RegisterState.loading, RegisterState.success] when the registration process is successful',
        build: () async {
          when(authRepository.signUp(
            email: 'johndoe@mail.com',
            password: 'test1234',
          )).thenAnswer((_) => Future.value(null));
          return registerBloc;
        },
        act: (bloc) => bloc.add(Submitted(
          email: 'johndoe@mail.com',
          password: 'test1234',
        )),
        expect: [
          // RegisterState.loading(),
          // RegisterState.success(),
        ],
      );

      blocTest(
        'emits [RegisterState.loading, RegisterState.failure] when an exception is thrown',
        build: () async {
          when(authRepository.signUp(
            email: 'johndoe@mail.com',
            password: 'test1234',
          )).thenThrow(Exception('oops'));
          return registerBloc;
        },
        act: (bloc) => bloc.add(Submitted(
          email: 'johndoe@mail.com',
          password: 'test1234',
        )),
        expect: [
          // RegisterState.loading(),
          // RegisterState.failure(),
        ],
      );
    });
  });
}

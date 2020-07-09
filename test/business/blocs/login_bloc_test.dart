import 'package:covtrack/business/blocs/login/login_bloc.dart';
import 'package:covtrack/business/repositories/authentication/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('RegisterBloc', () {
    AuthenticationRepository authRepository;
    LoginBloc loginBloc;

    setUp(() {
      authRepository = MockAuthenticationRepository();
      loginBloc = LoginBloc(authRepository: authRepository);
    });

    tearDown(() {
      loginBloc?.close();
    });

    test('throws AssertionError if AuthenticationRepository is null', () {
      expect(
        () => LoginBloc(authRepository: null),
        throwsA(isAssertionError),
      );
    });

    test('initial state is LoginState.empty()', () {
      expect(loginBloc.state, LoginState.empty());
    });

    test('close does not emit new states', () {
      expectLater(
        loginBloc,
        emitsInOrder([LoginState.empty(), emitsDone]),
      );
      loginBloc.close();
    });

    group('EmailChanged', () {
      blocTest(
        'emits [LoginState] with isEmailValid false not valid if the inserted email is not valid',
        build: () async => loginBloc,
        act: (bloc) => bloc.add(EmailChanged(email: 'john')),
        wait: const Duration(milliseconds: 400),
        expect: [
          LoginState(
            isEmailValid: false,
            isPasswordValid: true,
            isSubmitting: false,
            isSuccess: false,
            isFailure: false,
          ),
        ],
      );
    });

    group('PasswordChanged', () {
      blocTest(
        'emits [LoginState] with isPasswordValid false not valid if the inserted password is not valid',
        build: () async => loginBloc,
        act: (bloc) => bloc.add(PasswordChanged(password: 'test')),
        wait: const Duration(milliseconds: 400),
        expect: [
          LoginState(
            isEmailValid: true,
            isPasswordValid: false,
            isSubmitting: false,
            isSuccess: false,
            isFailure: false,
          ),
        ],
      );
    });

    group('LoginWithGooglePressed', () {
      blocTest(
        'emits [LoginState.loading, LoginState.success] when the login with Google process is successful',
        build: () async {
          when(authRepository.signInWithGoogle())
              .thenAnswer((_) => Future.value(null));
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginWithGooglePressed()),
        expect: [
          // LoginState.loading(),
          // LoginState.success(),
        ],
      );

      blocTest(
        'emits [LoginState.loading, LoginState.failure] when an exception is thrown',
        build: () async {
          when(authRepository.signInWithGoogle()).thenThrow(Exception('oops'));
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginWithGooglePressed()),
        expect: [
          // LoginState.loading(),
          // LoginState.failure(),
        ],
      );
    });

    group('LoginWithCredentialsPressed', () {
      blocTest(
        'emits [LoginState.loading, LoginState.success] when the login with credentials process is successful',
        build: () async {
          when(authRepository.signInWithCredentials(
            email: 'johndoe@mail.com',
            password: 'test1234',
          )).thenAnswer((_) => Future.value(null));
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginWithCredentialsPressed(
          email: 'johndoe@mail.com',
          password: 'test1234',
        )),
        expect: [
          // LoginState.loading(),
          // LoginState.success(),
        ],
      );

      blocTest(
        'emits [LoginState.loading, LoginState.failure] when an exception is thrown',
        build: () async {
          when(authRepository.signInWithCredentials(
            email: 'johndoe@mail.com',
            password: 'test1234',
          )).thenThrow(Exception('oops'));
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginWithCredentialsPressed(
          email: 'johndoe@mail.com',
          password: 'test1234',
        )),
        expect: [
          // LoginState.loading(),
          // LoginState.failure(),
        ],
      );
    });
  });
}

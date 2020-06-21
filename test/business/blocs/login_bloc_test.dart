import 'package:covtrack/business/blocs/login/login_bloc.dart';
import 'package:covtrack/business/repositories/authentication/authentication_repository.dart';
import 'package:covtrack/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('LoginBloc', () {
    AuthenticationRepository authRepository;
    LoginBloc loginBloc;
    String email;

    setUp(() {
      authRepository = MockAuthenticationRepository();
      loginBloc = LoginBloc(authRepository: authRepository);
      email = 'johndoe@mail.com';
    });

    test('throws AssertionError if AuthenticationRepository is null', () {
      expect(
        () => LoginBloc(authRepository: null),
        throwsA(isAssertionError),
      );
    });

    test('initial state is LoginState.empty()', () {
      expect(loginBloc.initialState, LoginState.empty());
    });

    group('EmailChanged', () {
      blocTest(
        'emits [LoginState] with isEmailValid true',
        build: () async => loginBloc,
        act: (bloc) async => bloc.add(EmailChanged(email: email)),
        wait: const Duration(milliseconds: 300),
        expect: [LoginState.empty().update(isEmailValid: true)],
      );
    });

    group('PasswordChanged', () {
      blocTest(
        'emits [LoginState] with isPasswordValid true',
        build: () async => loginBloc,
        act: (bloc) async =>
            bloc.add(PasswordChanged(password: 'Password1234')),
      );
    });

    group('LoginWithGooglePressed', () {
      blocTest(
        'emits LoginState.success() when no exception is raised',
        build: () async {
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginWithGooglePressed()),
        expect: [LoginState.success()],
      );
    });
  });
}

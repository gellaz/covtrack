import 'package:covtrack/business/blocs/login/login_bloc.dart';
import 'package:covtrack/business/repositories/authentication/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  AuthenticationRepository authRepository;
  LoginBloc loginBloc;

  group('LoginBloc', () {
    setUp(() {
      authRepository = MockAuthenticationRepository();
      loginBloc = LoginBloc(authRepository: authRepository);
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
        'emits [LoginState.empty, LoginState.loading, LoginState.success] when EmailChanged is added and signInWithCredentials succeeds',
        build: () async => loginBloc,
        act: (bloc) async => bloc.add(
          EmailChanged(email: 'marcogelli1994@hotmail.it'),
        ),
        expect: [
          LoginState.empty(),
          LoginState.loading(),
          LoginState.success(),
        ],
      );
    });
  });
}

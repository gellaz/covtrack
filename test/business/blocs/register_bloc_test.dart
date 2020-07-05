import 'package:covtrack/business/blocs/register/register_bloc.dart';
import 'package:covtrack/business/repositories/authentication/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('ChangePasswordBloc', () {
    AuthenticationRepository authRepository;
    RegisterBloc registerBloc;

    setUp(() {
      authRepository = MockAuthenticationRepository();
      registerBloc = RegisterBloc(authRepository: authRepository);
    });

    test('throws AssertionError if AuthenticationRepository is null', () {
      expect(
        () => RegisterBloc(authRepository: null),
        throwsA(isAssertionError),
      );
    });
    test('initial state is RegisterState.empty()', () {
      expect(registerBloc.state, RegisterState.empty());
    });
  });
}

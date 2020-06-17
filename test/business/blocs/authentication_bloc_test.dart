import 'package:covtrack/business/blocs/authentication/authentication_bloc.dart';
import 'package:covtrack/business/repositories/authentication/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('AuthenticationBloc', () {
    AuthenticationRepository authRepository;
    AuthenticationBloc authBloc;

    setUp(() {
      authRepository = MockAuthenticationRepository();
      authBloc = AuthenticationBloc(authRepository: authRepository);
    });

    test('throws AssertionError if AuthenticationRepository is null', () {
      expect(
        () => AuthenticationBloc(authRepository: null),
        throwsA(isAssertionError),
      );
    });

    test('initial state is Uninitialized', () {
      expect(authBloc.initialState, Uninitialized());
    });
  });
}

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

    test('throws AssertionError if AuthenticationRepository is null', () {
      expect(
        () => ChangePasswordBloc(authRepository: null),
        throwsA(isAssertionError),
      );
    });

    test('initial state is ChangePasswordState.empty()', () {
      expect(changePasswordBloc.state, ChangePasswordState.empty());
    });

    blocTest(
      'testingthisshit',
      build: () async {
        return changePasswordBloc;
      },
      act: (bloc) => bloc.add(OldPasswordChanged(password: 'test1234')),
      expect: [ChangePasswordState.empty().update(isOldPasswordValid: true)],
      wait: Duration(milliseconds: 300),
    );
  });
}

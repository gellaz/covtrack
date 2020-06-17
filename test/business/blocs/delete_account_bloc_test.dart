import 'package:covtrack/business/blocs/delete_account/delete_account_bloc.dart';
import 'package:covtrack/business/repositories/authentication/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('ChangePasswordBloc', () {
    AuthenticationRepository authRepository;
    DeleteAccountBloc deleteAccountBloc;

    setUp(() {
      authRepository = MockAuthenticationRepository();
      deleteAccountBloc = DeleteAccountBloc(authRepository: authRepository);
    });

    test('throws AssertionError if AuthenticationRepository is null', () {
      expect(
        () => DeleteAccountBloc(authRepository: null),
        throwsA(isAssertionError),
      );
    });
    test('initial state is DeleteAccountState.empty()', () {
      expect(deleteAccountBloc.initialState, DeleteAccountState.empty());
    });
  });
}

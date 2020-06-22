import 'package:covtrack/business/blocs/delete_account/delete_account_bloc.dart';
import 'package:covtrack/business/repositories/authentication/authentication_repository.dart';
import 'package:covtrack/business/repositories/old_destinations/old_destinations_repository.dart';
import 'package:covtrack/business/repositories/trips/trips_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockTripsRepository extends Mock implements TripsRepository {}

class MockOldDestinationsRepository extends Mock
    implements OldDestinationsRepository {}

void main() {
  group('ChangePasswordBloc', () {
    AuthenticationRepository authRepository;
    TripsRepository tripsRepository;
    OldDestinationsRepository oldDestinationsRepository;
    DeleteAccountBloc deleteAccountBloc;

    setUp(() {
      authRepository = MockAuthenticationRepository();
      deleteAccountBloc = DeleteAccountBloc(
        authRepository: authRepository,
        tripsRepository: tripsRepository,
        oldDestinationsRepository: oldDestinationsRepository,
      );
    });

    test('throws AssertionError if AuthenticationRepository is null', () {
      expect(
        () => DeleteAccountBloc(
          authRepository: null,
          tripsRepository: tripsRepository,
          oldDestinationsRepository: oldDestinationsRepository,
        ),
        throwsA(isAssertionError),
      );
    });

    test('throws AssertionError if TripsRepository is null', () {
      expect(
        () => DeleteAccountBloc(
          authRepository: authRepository,
          tripsRepository: null,
          oldDestinationsRepository: oldDestinationsRepository,
        ),
        throwsA(isAssertionError),
      );
    });

    test('throws AssertionError if OldDestinationsRepository is null', () {
      expect(
        () => DeleteAccountBloc(
          authRepository: authRepository,
          tripsRepository: tripsRepository,
          oldDestinationsRepository: null,
        ),
        throwsA(isAssertionError),
      );
    });

    test('initial state is DeleteAccountState.empty()', () {
      expect(deleteAccountBloc.initialState, DeleteAccountState.empty());
    });
  });
}

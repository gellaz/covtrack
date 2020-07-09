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
  group('DeleteAccountBloc', () {
    AuthenticationRepository authRepository;
    TripsRepository tripsRepository;
    OldDestinationsRepository oldDestinationsRepository;
    DeleteAccountBloc deleteAccountBloc;

    setUp(() {
      authRepository = MockAuthenticationRepository();
      tripsRepository = MockTripsRepository();
      oldDestinationsRepository = MockOldDestinationsRepository();
      deleteAccountBloc = DeleteAccountBloc(
        authRepository: authRepository,
        tripsRepository: tripsRepository,
        oldDestinationsRepository: oldDestinationsRepository,
      );
    });

    tearDown(() {
      deleteAccountBloc?.close();
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

    test('initial state is DeleteAccountState.empty', () {
      expect(deleteAccountBloc.state, DeleteAccountState.empty());
    });

    test('close does not emit new states', () {
      expectLater(
        deleteAccountBloc,
        emitsInOrder([DeleteAccountState.empty(), emitsDone]),
      );
      deleteAccountBloc.close();
    });

    group('PasswordChanged', () {
      blocTest(
        'emits [DeleteAccountState] with password not valid if the inserted password is not valid',
        build: () async => deleteAccountBloc,
        act: (bloc) => bloc.add(PasswordChanged(password: 'test')),
        wait: const Duration(milliseconds: 400),
        expect: [
          DeleteAccountState(
            isPasswordValid: false,
            isSubmitting: false,
            isSuccess: false,
            isFailure: false,
          ),
        ],
      );
    });

    group('Submitted', () {
      blocTest(
        'emits [DeleteAccountState.loading, DeleteAccountState.success] when the account is successfully deleted',
        build: () async {
          when(tripsRepository.clear()).thenAnswer((_) => Future.value(null));
          when(oldDestinationsRepository.clear())
              .thenAnswer((_) => Future.value(null));
          when(authRepository.deleteAccount(password: 'test1234'))
              .thenAnswer((_) => Future.value(null));
          return deleteAccountBloc;
        },
        act: (bloc) => bloc.add(Submitted(password: 'test1234')),
        expect: [
          // DeleteAccountState.loading(),
          // DeleteAccountState.success(),
        ],
      );

      blocTest(
        'emits [DeleteAccountState.loading, DeleteAccountState.failure] when an exception is thrown',
        build: () async {
          when(tripsRepository.clear()).thenAnswer((_) => Future.value(null));
          when(oldDestinationsRepository.clear()).thenThrow(Exception('oops'));
          when(authRepository.deleteAccount(password: 'test1234'))
              .thenAnswer((_) => Future.value(null));
          return deleteAccountBloc;
        },
        act: (bloc) => bloc.add(Submitted(password: 'test1234')),
        expect: [
          // DeleteAccountState.loading(),
          // DeleteAccountState.failure(),
        ],
      );
    });
  });
}

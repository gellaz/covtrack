import 'package:covtrack/business/blocs/authentication/authentication_bloc.dart';
import 'package:covtrack/business/repositories/authentication/authentication_repository.dart';
import 'package:covtrack/data/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('AuthenticationBloc', () {
    AuthenticationRepository authRepository;
    AuthenticationBloc authBloc;
    User user = User(
      uid: 'AbCd1234',
      email: 'johndoe@mail.com',
    );

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
      expect(authBloc.state, Uninitialized());
    });

    group('AppStarted', () {
      blocTest(
        'emits [Authenticated] if the user is signed in',
        build: () async {
          when(authRepository.isSignedIn()).thenAnswer((_) async => true);
          when(authRepository.getUser()).thenAnswer((_) async => user);
          return authBloc;
        },
        act: (bloc) => bloc.add(AppStarted()),
        expect: [Authenticated(user)],
      );
      blocTest(
        'emits [Unauthenticated] if the user is not signed in',
        build: () async {
          when(authRepository.isSignedIn()).thenAnswer((_) async => false);
          return authBloc;
        },
        act: (bloc) => bloc.add(AppStarted()),
        expect: [Unauthenticated()],
      );
    });

    group('LoggedIn', () {
      blocTest(
        'emits [Authenticated]',
        build: () async {
          when(authRepository.getUser()).thenAnswer((_) async => user);
          return authBloc;
        },
        act: (bloc) => bloc.add(LoggedIn()),
        expect: [Authenticated(user)],
      );
    });

    group('LoggedOut', () {
      blocTest(
        'emits [Unauthenticated]',
        build: () async => authBloc,
        act: (bloc) => bloc.add(LoggedOut()),
        expect: [Unauthenticated()],
      );
    });
  });
}

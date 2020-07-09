import 'package:bloc_test/bloc_test.dart';
import 'package:covtrack/business/blocs/authentication/authentication_bloc.dart';
import 'package:covtrack/business/blocs/change_password/change_password_bloc.dart';
import 'package:covtrack/business/blocs/settings/settings_bloc.dart';
import 'package:covtrack/business/repositories/authentication/authentication_repository.dart';
import 'package:covtrack/data/user.dart';
import 'package:covtrack/presentation/screens/change_password_screen.dart';
import 'package:covtrack/presentation/screens/login_screen.dart';
import 'package:covtrack/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSettingsBloc extends MockBloc implements SettingsBloc {}

class MockAuthenticationBloc extends MockBloc implements AuthenticationBloc {}

class MockChangePasswordBloc extends MockBloc implements ChangePasswordBloc {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('ChangePasswordScreen', () {
    AuthenticationRepository authenticationRepository;
    AuthenticationBloc authenticationBloc;
    ChangePasswordBloc changePasswordBloc;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      authenticationBloc = MockAuthenticationBloc();
      changePasswordBloc = MockChangePasswordBloc();
    });

    tearDownAll(() {
      authenticationBloc?.close();
      changePasswordBloc?.close();
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      when(changePasswordBloc.state)
          .thenAnswer((_) => ChangePasswordState.empty());
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<ChangePasswordBloc>.value(
                value: changePasswordBloc,
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: ChangePasswordScreen(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(RaisedButton), findsOneWidget);
    });

    testWidgets(
        'navigates to login screen when raised button is tapped and password is successfully changed',
        (WidgetTester tester) async {
      when(changePasswordBloc.state).thenAnswer(
        (_) => ChangePasswordState(
          isOldPasswordValid: true,
          isNewPasswordValid: true,
          isNewPasswordCheckValid: true,
          isSubmitting: false,
          isSuccess: false,
          isFailure: false,
        ),
      );
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>.value(
                value: authenticationBloc,
              ),
              BlocProvider<ChangePasswordBloc>.value(
                value: changePasswordBloc,
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: ChangePasswordScreen(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(RaisedButton));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/settings/settings_bloc.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'screens/onboarding.dart';
import 'screens/splashscreen.dart';
import 'screens/wrappers/authentication_wrapper.dart';
import 'services/authentication/authentication_service.dart';
import 'services/authentication/firebase_authentication_service.dart';
import 'services/places/mock_places_service.dart';
import 'services/places/places_service.dart';
import 'services/settings/settings_service.dart';
import 'services/settings/sharedprefs_settings_service.dart';
import 'styles/themes.dart';

void main() {
  // Required in Flutter v1.9.4+ before using any plugins if
  // the code is executed before runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc delegate used for debugging.
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // Create the services used in the app.
  final settingsService = SharedPrefsSettingsService();
  final authService = FirebaseAuthenticationService();
  final placesService = MockPlacesService();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SettingsService>(
          create: (context) => settingsService,
        ),
        RepositoryProvider<AuthenticationService>(
          create: (context) => authService,
        ),
        RepositoryProvider<PlacesService>(
          create: (context) => placesService,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(create: (_) {
            return SettingsBloc(settingsService: settingsService)
              ..add(AppLoaded());
          }),
          BlocProvider<AuthenticationBloc>(create: (_) {
            return AuthenticationBloc(authService: authService)
              ..add(AppStarted());
          }),
        ],
        child: CovTrack(),
      ),
    ),
  );
}

class CovTrack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CovTrack',
      theme: Themes.light,
      home: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsCreated) {
            return Onboarding();
          }
          if (state is SettingsLoaded) {
            return AuthenticationWrapper();
          }
          return SplashScreen();
        },
      ),
    );
  }
}

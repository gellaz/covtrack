import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'business/blocs/authentication/authentication_bloc.dart';
import 'business/blocs/settings/settings_bloc.dart';
import 'business/blocs/simple_bloc_delegate.dart';
import 'business/blocs/trips/trips_bloc.dart';
import 'business/repositories/authentication/authentication_repository.dart';
import 'business/repositories/authentication/firebase_authentication_repository.dart';
import 'business/repositories/info/info_api_repository.dart';
import 'business/repositories/info/info_repository.dart';
import 'business/repositories/location/geolocator_location_repository.dart';
import 'business/repositories/location/location_repository.dart';
import 'business/repositories/places/places_repository.dart';
import 'business/repositories/settings/settings_database_repository.dart';
import 'business/repositories/settings/settings_repository.dart';
import 'business/repositories/trips/trips_database_repository.dart';
import 'presentation/containers/authentication_container.dart';
import 'presentation/screens/error_screen.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/styles/themes.dart';
import 'utils/app_localizations.dart';

void main() {
  // Required in Flutter v1.9.4+ before using any plugins if
  // the code is executed before runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc delegate used for debugging.
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // Create the repositories.
  final authRepository = FirebaseAuthenticationRepository();
  final locationRepository = GeolocatorLocationRepository();
  final placesRepository = GooglePlacesRepository();
  final settingsRepository = SettingsDatabaseRepository();
  final tripsRepository = TripsDatabaseRepository();
  final infoRepository = InfoApiRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authRepository,
        ),
        RepositoryProvider<LocationRepository>(
          create: (context) => locationRepository,
        ),
        RepositoryProvider<PlacesRepository>(
          create: (context) => placesRepository,
        ),
        RepositoryProvider<SettingsRepository>(
          create: (context) => settingsRepository,
        ),
        RepositoryProvider<InfoRepository>(
          create: (context) => infoRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(create: (_) {
            return SettingsBloc(settingsRepository)..add(AppLoaded());
          }),
          BlocProvider<AuthenticationBloc>(create: (_) {
            return AuthenticationBloc(authRepository)..add(AppStarted());
          }),
          BlocProvider<TripsBloc>(create: (_) {
            return TripsBloc(tripsRepository)..add(TripsLoaded());
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
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('it', 'IT'), // Italian
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      home: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoadInProgress) {
            return SplashScreen();
          }
          if (state is SettingsLoadSuccess) {
            if (state.settings['firstRun']) {
              return OnboardingScreen();
            } else
              return AuthenticationContainer();
          }
          if (state is SettingsLoadFailure) {
            return ErrorScreen();
          }
          return ErrorScreen();
        },
      ),
    );
  }
}

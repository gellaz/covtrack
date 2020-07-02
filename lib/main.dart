import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'business/blocs/authentication/authentication_bloc.dart';
import 'business/blocs/settings/settings_bloc.dart';
import 'business/blocs/simple_bloc_delegate.dart';
import 'business/repositories/authentication/authentication_repository.dart';
import 'business/repositories/authentication/firebase_authentication_repository.dart';
import 'business/repositories/location/geolocator_location_repository.dart';
import 'business/repositories/location/location_repository.dart';
import 'business/repositories/news/api_news_repository.dart';
import 'business/repositories/news/news_repository.dart';
import 'business/repositories/places/google_places_repository.dart';
import 'business/repositories/places/places_repository.dart';
import 'business/repositories/settings/settings_repository.dart';
import 'business/repositories/settings/sharedprefs_settings_repository.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/styles/themes.dart';
import 'utils/app_localizations.dart';

void main() async {
  // Required in Flutter v1.9.4+ before using any plugins if
  // the code is executed before runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc delegate used for debugging.
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // Fetching Google Maps API key from Firebase.
  final String googleApiKey = await getGoogleApiKey();

  // Create the repositories.
  final authRepository = FirebaseAuthenticationRepository();
  final locationRepository = GeolocatorLocationRepository();
  final placesRepository = GooglePlacesRepository(googleApiKey: googleApiKey);
  final settingsRepository = SharedPrefsSettingsRepository();
  final newsRepository = ApiNewsRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (_) => authRepository,
        ),
        RepositoryProvider<LocationRepository>(
          create: (_) => locationRepository,
        ),
        RepositoryProvider<PlacesRepository>(
          create: (_) => placesRepository,
        ),
        RepositoryProvider<SettingsRepository>(
          create: (_) => settingsRepository,
        ),
        RepositoryProvider<NewsRepository>(
          create: (_) => newsRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) {
            return SettingsBloc(settingsRepository: settingsRepository)
              ..add(AppLoaded());
          }),
          BlocProvider(create: (_) {
            return AuthenticationBloc(authRepository: authRepository)
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
    // Preventing device orientation changes and force portrait.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoadSuccess) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CovTrack',
            theme: state.settings['theme'] == 'dark'
                ? AppTheme.dark
                : AppTheme.light,
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
              // Checking if the current device locale is supported.
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
            home: SplashScreen(),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

/// Returns the API key to access the Google Maps web services. The key is saved in a
/// remote configuration file in the Firebase back-end.
Future<String> getGoogleApiKey() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  await remoteConfig.fetch(expiration: Duration(hours: 1));
  await remoteConfig.activateFetched();
  return remoteConfig.getValue('google_api_key').asString();
}

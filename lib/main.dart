import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/houses/houses_bloc.dart';
import 'blocs/settings/settings_bloc.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'providers/database_provider.dart';
import 'repositories/authentication/authentication_repository.dart';
import 'repositories/houses/houses_database_repository.dart';
import 'repositories/houses/houses_repository.dart';
import 'repositories/location/geolocator_location_repository.dart';
import 'repositories/location/location_repository.dart';
import 'repositories/places/places_repository.dart';
import 'repositories/settings/settings_repository.dart';
import 'screens/onboarding.dart';
import 'screens/splash_screen.dart';
import 'screens/wrappers/authentication_wrapper.dart';
import 'styles/themes.dart';

void main() {
  // Required in Flutter v1.9.4+ before using any plugins if
  // the code is executed before runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc delegate used for debugging.
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // Create the services used in the app.
  final settingsRepository = SharedPrefsSettingsRepository();
  final authRepository = FirebaseAuthenticationRepository();
  final placesRepository = GooglePlacesRepository();
  final locationRepository = GeolocatorLocationRepository();

  // Create the providers.
  final databaseProvider = DatabaseProvider.instance;

  // Create the repositories.
  final housesRepository = HousesDatabaseRepository(databaseProvider);

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
        RepositoryProvider<HousesRepository>(
          create: (context) => housesRepository,
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(create: (_) {
            return SettingsBloc(settingsRepository)..add(AppLoaded());
          }),
          BlocProvider<AuthenticationBloc>(create: (_) {
            return AuthenticationBloc(authRepository)..add(AppStarted());
          }),
          BlocProvider<HousesBloc>(create: (_) {
            return HousesBloc(housesRepository);
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

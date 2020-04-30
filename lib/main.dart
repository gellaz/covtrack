import 'package:covtrack/screens/splashscreen.dart';

import 'screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/settings/settings_bloc.dart';
import 'repositories/settings_repository.dart';
import 'screens/onboarding.dart';
import 'themes/themes.dart';
import 'utils/simple_bloc_delegate.dart';

void main() {
  // Required in Flutter v1.9.4+ before using any plugins if
  // the code is executed before runApp.
  WidgetsFlutterBinding.ensureInitialized();
  // Create the bloc delegate, that will help during debugging.
  BlocSupervisor.delegate = SimpleBlocDelegate();
  // Create instances of the repositories to supply to the app.
  final SettingsRepository settingsRepository = SettingsRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (context) =>
              SettingsBloc(settingsRepository: settingsRepository)
                ..add(AppLaunched()),
        ),
      ],
      child: CovTrack(),
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
          if (state is SettingsLoading) {
            return SplashScreen();
          } else if (state is SettingsLoaded) {
            final firstScreen = state.isFirstLaunch ? Onboarding() : Home();
            return firstScreen;
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/settings/settings_bloc.dart';
import 'repositories/settings_repository.dart';
import 'repositories/user_repository.dart';
import 'screens/onboarding.dart';
import 'screens/splashscreen.dart';
import 'screens/wrappers/authentication_wrapper.dart';
import 'themes/themes.dart';
import 'utils/simple_bloc_delegate.dart';

void main() {
  // Required in Flutter v1.9.4+ before using any plugins if
  // the code is executed before runApp.
  WidgetsFlutterBinding.ensureInitialized();
  // Create the bloc delegate, that will help during debugging.
  BlocSupervisor.delegate = SimpleBlocDelegate();
  // Create instances of the repositories to supply them to the app.
  final settingsRepository = SettingsRepository();
  final userRepository = UserRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        /**
         * 
         */
        BlocProvider<SettingsBloc>(create: (_) {
          return SettingsBloc(settingsRepository: settingsRepository)
            ..add(AppLaunched());
        }),
        /**
         * 
         */
        BlocProvider<AuthenticationBloc>(create: (_) {
          return AuthenticationBloc(userRepository: userRepository)
            ..add(AppStarted());
        }),
        /**
         * 
         */
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
            final firstScreen =
                state.isFirstLaunch ? Onboarding() : AuthenticationWrapper();
            return firstScreen;
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}

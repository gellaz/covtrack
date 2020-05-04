import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication_bloc.dart' as ab;
import 'blocs/settings/settings_bloc.dart' as sb;
import 'blocs/simple_bloc_delegate.dart';
import 'screens/onboarding.dart';
import 'screens/splashscreen.dart';
import 'screens/wrappers/authentication_wrapper.dart';
import 'services/authentication/authentication_service.dart';
import 'services/authentication/firebase_authentication_service.dart';
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

  runApp(
    MultiBlocProvider(
      providers: [
        /**
         * 
         */
        BlocProvider<sb.SettingsBloc>(create: (_) {
          return sb.SettingsBloc(settingsService: settingsService)
            ..add(sb.AppStarted());
        }),
        /**
         * 
         */
        BlocProvider<ab.AuthenticationBloc>(create: (_) {
          return ab.AuthenticationBloc(authService: authService)
            ..add(ab.AppStarted());
        }),
        /**
         * 
         */
      ],
      child: CovTrack(
        authService: authService,
      ),
    ),
  );
}

class CovTrack extends StatelessWidget {
  final AuthenticationService authService;

  const CovTrack({Key key, @required this.authService})
      : assert(authService != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CovTrack',
      theme: Themes.light,
      home: BlocBuilder<sb.SettingsBloc, sb.SettingsState>(
        builder: (context, state) {
          if (state is sb.SettingsCreated) {
            return Onboarding(authService: authService);
          }
          if (state is sb.SettingsLoaded) {
            return AuthenticationWrapper(authService: authService);
          }
          return SplashScreen();
        },
      ),
    );
  }
}

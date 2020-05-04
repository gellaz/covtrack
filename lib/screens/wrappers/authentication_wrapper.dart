import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../services/authentication/authentication_service.dart';
import '../error_screen.dart';
import '../login/login_screen.dart';
import '../root_screen.dart';
import '../splashscreen.dart';

class AuthenticationWrapper extends StatelessWidget {
  final AuthenticationService authService;

  const AuthenticationWrapper({Key key, @required this.authService})
      : assert(authService != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Uninitialized) {
          return SplashScreen();
        }
        if (state is Unauthenticated) {
          return LoginScreen(authService: authService);
        }
        if (state is Authenticated) {
          return RootScreen();
        }
        return ErrorScreen();
      },
    );
  }
}

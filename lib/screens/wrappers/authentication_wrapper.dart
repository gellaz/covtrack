import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../error_screen.dart';
import '../home_sceen.dart';
import '../login_screen.dart';
import '../splashscreen.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Uninitialized) {
          return SplashScreen();
        }
        if (state is Unauthenticated) {
          return LoginScreen();
        }
        if (state is Authenticated) {
          return HomeScreen();
        }
        return ErrorScreen();
      },
    );
  }
}

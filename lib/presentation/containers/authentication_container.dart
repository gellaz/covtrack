import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/authentication/authentication_bloc.dart';
import '../screens/error_screen.dart';
import '../screens/login_screen.dart';
import '../screens/root_screen.dart';
import '../screens/splash_screen.dart';

class AuthenticationContainer extends StatelessWidget {
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
          return RootScreen();
        }
        return ErrorScreen();
      },
    );
  }
}

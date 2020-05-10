import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../error_screen.dart';
import '../login/login_screen.dart';
import '../root_screen.dart';
import '../splash_screen.dart';

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
          return RootScreen();
        }
        return ErrorScreen();
      },
    );
  }
}

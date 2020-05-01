import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../repositories/user_repository.dart';
import '../error_screen.dart';
import '../home_sceen.dart';
import '../login/login_screen.dart';
import '../splashscreen.dart';

class AuthenticationWrapper extends StatelessWidget {
  final UserRepository userRepository;

  const AuthenticationWrapper({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Uninitialized) {
          return SplashScreen();
        }
        if (state is Unauthenticated) {
          return LoginScreen(userRepository: userRepository);
        }
        if (state is Authenticated) {
          return HomeScreen();
        }
        return ErrorScreen();
      },
    );
  }
}

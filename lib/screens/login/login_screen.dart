import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/login/login_bloc.dart';
import '../../services/authentication/authentication_service.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authService: RepositoryProvider.of<AuthenticationService>(context),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}

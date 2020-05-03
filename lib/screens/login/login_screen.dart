import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/login/login_bloc.dart';
import '../../services/authentication/authentication_service.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final AuthenticationService authService;

  const LoginScreen({Key key, @required this.authService})
      : assert(authService != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authService: authService),
        child: LoginForm(authService: authService),
      ),
    );
  }
}

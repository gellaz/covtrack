import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/register/register_bloc.dart';
import '../../services/authentication/authentication_service.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
            authService: RepositoryProvider.of<AuthenticationService>(context),
          ),
          child: RegisterForm(),
        ),
      ),
    );
  }
}

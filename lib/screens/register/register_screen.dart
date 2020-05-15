import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/register/register_bloc.dart';
import '../../repositories/authentication/authentication_repository.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
            RepositoryProvider.of<AuthenticationRepository>(context),
          ),
          child: RegisterForm(),
        ),
      ),
    );
  }
}

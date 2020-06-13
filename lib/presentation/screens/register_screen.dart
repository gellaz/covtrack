import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/register/register_bloc.dart';
import '../../business/repositories/authentication/authentication_repository.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
            authRepository: context.repository<AuthenticationRepository>(),
          ),
          child: RegisterForm(),
        ),
      ),
    );
  }
}

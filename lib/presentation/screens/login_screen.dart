import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/login/login_bloc.dart';
import '../../business/repositories/authentication/authentication_repository.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            context.repository<AuthenticationRepository>(),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}

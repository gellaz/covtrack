import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/register/register_bloc.dart';
import '../../repositories/user_repository.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository userRepository;

  RegisterScreen({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: userRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}

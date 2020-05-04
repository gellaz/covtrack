import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';

class LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context).add(
          LoggedOut(),
        );
      },
    );
  }
}

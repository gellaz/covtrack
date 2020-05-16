import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/authentication/authentication_bloc.dart';

/// Button used to log out from the application. It can be found
/// on the top right corner of each screen when logged in.
class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      onPressed: () => context.bloc<AuthenticationBloc>().add(LoggedOut()),
    );
  }
}

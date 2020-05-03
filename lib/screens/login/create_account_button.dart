import 'package:flutter/material.dart';

import '../../services/authentication/authentication_service.dart';
import '../register/register_screen.dart';

class CreateAccountButton extends StatelessWidget {
  final AuthenticationService authService;

  CreateAccountButton({Key key, @required this.authService})
      : assert(authService != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(authService: authService);
          }),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../../services/authentication/authentication_service.dart';
import '../register/register_screen.dart';

class RegisterLink extends StatelessWidget {
  final AuthenticationService authService;

  RegisterLink({Key key, @required this.authService})
      : assert(authService != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        'Create an account',
        style: Theme.of(context).textTheme.overline,
        textAlign: TextAlign.center,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(authService: authService);
          }),
        );
      },
    );
  }
}

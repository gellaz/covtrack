import 'package:flutter/material.dart';

import '../screens/register_screen.dart';

class RegisterLink extends StatelessWidget {
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
            return RegisterScreen();
          }),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class LoginLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        'Login with your account',
        style: Theme.of(context).textTheme.overline,
        textAlign: TextAlign.center,
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}

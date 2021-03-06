import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';
import '../screens/register_screen.dart';

class RegisterLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        AppLocalizations.of(context).createAccount,
        style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: Colors.lightBlue,
              decoration: TextDecoration.underline,
            ),
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

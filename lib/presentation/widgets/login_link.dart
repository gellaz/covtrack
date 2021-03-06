import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';

class LoginLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        AppLocalizations.of(context).loginWithYourAccount,
        style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: Colors.lightBlue,
              decoration: TextDecoration.underline,
            ),
        textAlign: TextAlign.center,
      ),
      onTap: () => Navigator.of(context).pop(),
    );
  }
}

import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text(AppLocalizations.of(context).login),
    );
  }
}

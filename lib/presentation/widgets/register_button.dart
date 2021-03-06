import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text(AppLocalizations.of(context).register),
    );
  }
}

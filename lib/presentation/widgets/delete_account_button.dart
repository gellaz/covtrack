import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';

class DeleteAccountButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteAccountButton({Key key, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text(AppLocalizations.of(context).deleteAccount),
    );
  }
}

import 'package:covtrack/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class DeleteAccountDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).deleteAccountDialogTitle),
      content: Text(AppLocalizations.of(context).deleteAccountDialogContent),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).yes),
          onPressed: () {
            // Closes the AlertDialog.
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(AppLocalizations.of(context).no),
          onPressed: () {
            // Closes the AlertDialog.
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

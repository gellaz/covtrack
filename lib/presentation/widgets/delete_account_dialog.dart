import 'package:flutter/material.dart';

import '../../business/blocs/delete_account/delete_account_bloc.dart';
import '../../utils/app_localizations.dart';

class DeleteAccountDialog extends StatelessWidget {
  final DeleteAccountBloc deleteAccountBloc;
  final String password;

  const DeleteAccountDialog({
    Key key,
    @required this.deleteAccountBloc,
    @required this.password,
  })  : assert(deleteAccountBloc != null),
        assert(password != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).deleteAccountDialogTitle),
      content: Text(AppLocalizations.of(context).deleteAccountDialogContent),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).yes),
          onPressed: () {
            // Notifies AuthenticationBloc of a new AccountDeleted event
            deleteAccountBloc.add(Submitted(password: password));

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

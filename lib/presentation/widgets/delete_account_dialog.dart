import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/delete_account/delete_account_bloc.dart';
import '../../utils/app_localizations.dart';

class DeleteAccountDialog extends StatelessWidget {
  final String password;

  const DeleteAccountDialog({
    Key key,
    @required this.password,
  })  : assert(password != null),
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
            // Notifies DeleteAccountBloc of a new Submiitted event.
            context
                .bloc<DeleteAccountBloc>()
                .add(Submitted(password: password));
            // Closes the AlertDialog.
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(AppLocalizations.of(context).no),
          onPressed: () {
            // Closes the AlertDialog.
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

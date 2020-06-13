import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/delete_account/delete_account_bloc.dart';
import '../../business/blocs/trips/trips_bloc.dart';
import '../../utils/app_localizations.dart';

class DeleteAccountDialog extends StatefulWidget {
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
  _DeleteAccountDialogState createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  TripsBloc _tripsBloc;

  @override
  void initState() {
    super.initState();
    _tripsBloc = context.bloc<TripsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).deleteAccountDialogTitle),
      content: Text(AppLocalizations.of(context).deleteAccountDialogContent),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).yes),
          onPressed: () {
            _tripsBloc.add(ClearCompleted());
            // Notifies AuthenticationBloc of a new AccountDeleted event.
            widget.deleteAccountBloc.add(Submitted(password: widget.password));
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

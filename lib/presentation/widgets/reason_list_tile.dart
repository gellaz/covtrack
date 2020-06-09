import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';

class ReasonListTile extends StatelessWidget {
  final String reason;

  const ReasonListTile({Key key, @required this.reason})
      : assert(reason != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.not_listed_location),
          ],
        ),
        title: Text(AppLocalizations.of(context).reasonPickerDesc),
        subtitle: Text(reason),
      ),
    );
  }
}

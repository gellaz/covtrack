import 'package:covtrack/utils/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../data/place.dart';

class DestinationListTile extends StatelessWidget {
  final Place destination;

  const DestinationListTile({Key key, @required this.destination})
      : assert(destination != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.pin_drop,
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
        title: Text(
          AppLocalizations.of(context).destination,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text.rich(
          TextSpan(
            text: '${destination.mainText}',
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            children: <TextSpan>[
              TextSpan(
                text: '\n${destination.secondaryText}',
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight, fontSize: 12),
              ),
            ],
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}

import 'package:covtrack/utils/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../data/place.dart';

class SourceListTile extends StatelessWidget {
  final Place source;

  const SourceListTile({Key key, @required this.source})
      : assert(source != null),
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
              Icons.place,
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
        title: Text(AppLocalizations.of(context).source),
        subtitle: Text.rich(
          TextSpan(
            text: '${source.mainText}',
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            children: <TextSpan>[
              TextSpan(
                text: '\n${source.secondaryText}',
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

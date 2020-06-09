import 'package:flutter/material.dart';

import '../../data/place.dart';
import '../../utils/app_localizations.dart';

class DestinationCard extends StatelessWidget {
  final Place place;
  final Function onButtonPressed;

  const DestinationCard({
    Key key,
    @required this.place,
    @required this.onButtonPressed,
  })  : assert(place != null),
        assert(onButtonPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(AppLocalizations.of(context).selectedDestination),
        subtitle: Text.rich(
          TextSpan(
            text: '${place.mainText}',
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            children: <TextSpan>[
              TextSpan(
                text: '\n${place.secondaryText}',
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight, fontSize: 12),
              ),
            ],
          ),
        ),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: onButtonPressed,
              child: Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}

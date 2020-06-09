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
            const Icon(Icons.pin_drop),
          ],
        ),
        title: Text('${destination.mainText}'),
        subtitle: Text('${destination.secondaryText}'),
        isThreeLine: true,
      ),
    );
  }
}

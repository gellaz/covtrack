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
            const Icon(Icons.place),
          ],
        ),
        title: Text('${source.mainText}'),
        subtitle: Text('${source.secondaryText}'),
        isThreeLine: true,
      ),
    );
  }
}

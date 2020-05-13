import 'package:covtrack/models/place.dart';
import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  final Place destination;

  const DestinationCard(this.destination, {Key key})
      : assert(destination != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${destination.mainText}'),
        subtitle: Text('${destination.secondaryText}'),
        trailing: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/home/displacement-detail',
              arguments: destination,
            );
          },
          child: Icon(Icons.keyboard_arrow_right),
        ),
      ),
      elevation: 5,
    );
  }
}

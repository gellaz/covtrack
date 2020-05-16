import 'package:flutter/material.dart';

import '../../data/models/place.dart';

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
      child: ListTile(
        title: Text('${place.mainText}'),
        subtitle: Text('${place.secondaryText}'),
        trailing: FloatingActionButton(
          onPressed: onButtonPressed,
          child: Icon(Icons.keyboard_arrow_right),
        ),
      ),
      elevation: 5,
    );
  }
}

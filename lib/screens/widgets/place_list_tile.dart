import 'package:covtrack/models/place.dart';
import 'package:flutter/material.dart';

class PlaceListTile extends StatelessWidget {
  final Place place;

  const PlaceListTile({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        // TODO: implement place list tile.
        // leading: Icon(Icons.pin_drop),
        // title: Text(place.address),
        );
  }
}

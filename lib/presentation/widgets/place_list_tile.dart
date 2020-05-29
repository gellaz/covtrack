import 'package:flutter/material.dart';

import '../../data/place.dart';

enum PlaceType { Source, Destination }

class PlaceListTile extends StatelessWidget {
  final Place place;
  final PlaceType placeType;

  const PlaceListTile(this.place, this.placeType, {Key key})
      : assert(place != null),
        assert(placeType != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: _buildIcon(),
        title: Text('${place.mainText}'),
        subtitle: Text('${place.secondaryText}'),
      ),
    );
  }

  Widget _buildIcon() {
    return placeType == PlaceType.Source
        ? Icon(Icons.place)
        : Icon(Icons.pin_drop);
  }
}

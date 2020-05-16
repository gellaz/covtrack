import 'package:flutter/material.dart';

import '../../data/models/place.dart';

enum PlaceType { Home, Destination }

class PlaceListTile extends StatelessWidget {
  final Place place;
  final PlaceType placeType;

  const PlaceListTile(this.place, this.placeType, {Key key})
      : assert(place != null),
        assert(placeType != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildIcon(),
      title: Text('${place.mainText}'),
      subtitle: Text('${place.secondaryText}'),
    );
  }

  Widget _buildIcon() {
    return placeType == PlaceType.Home
        ? Icon(Icons.home)
        : Icon(Icons.pin_drop);
  }
}

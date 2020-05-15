import 'package:flutter/material.dart';

import '../../models/place.dart';
import 'place_list_tile.dart';
import 'reason_picker.dart';

class TripDetailsScreen extends StatelessWidget {
  final Place destination;

  const TripDetailsScreen(this.destination, {Key key})
      : assert(destination != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Details'),
      ),
      body: Column(
        children: <Widget>[
          PlaceListTile(destination, PlaceType.Home),
          PlaceListTile(destination, PlaceType.Destination),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ReasonPicker(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Start Trip'),
        icon: Icon(Icons.keyboard_arrow_right),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

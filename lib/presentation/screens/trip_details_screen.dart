import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/trips/trips_bloc.dart';
import '../../data/models/place.dart';
import '../../data/models/trip.dart';
import '../widgets/place_list_tile.dart';
import '../widgets/reason_picker.dart';

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
        icon: Icon(Icons.keyboard_arrow_right),
        label: Text('Start Trip'),
        onPressed: () => _onPressed(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onPressed(BuildContext context) {
    context.bloc<TripsBloc>().add(
          TripAdded(
            Trip(
                reason: 'aaaa',
                startingTime: DateTime.now(),
                arrivalTime: DateTime.now(),
                source: destination,
                destination: destination),
          ),
        );
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}

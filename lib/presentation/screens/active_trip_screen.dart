import 'package:flutter/material.dart';

import '../../data/trip.dart';
import '../../utils/app_localizations.dart';
import '../widgets/destination_list_tile.dart';
import '../widgets/numstops_list_tile.dart';
import '../widgets/reason_list_tile.dart';
import '../widgets/return_trip_button.dart';
import '../widgets/show_qr_button.dart';
import '../widgets/source_list_tile.dart';
import '../widgets/stop_trip_button.dart';
import '../widgets/stopwatch_list_tile.dart';

class ActiveTripScreen extends StatelessWidget {
  final Trip activeTrip;

  const ActiveTripScreen(this.activeTrip, {Key key})
      : assert(activeTrip != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).activeTrip,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Padding(
                  padding: const EdgeInsets.all(10),
                  child: const Divider(),
                ),
                SourceListTile(source: activeTrip.source),
                DestinationListTile(destination: activeTrip.destination),
                ReasonListTile(reason: activeTrip.reason),
                NumStopsListTile(),
                StopwatchListTile(),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
              children: <Widget>[
                ShowQrButton(activeTrip: activeTrip),
                StopTripButton(activeTrip: activeTrip),
                ReturnTripButton(activeTrip: activeTrip),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

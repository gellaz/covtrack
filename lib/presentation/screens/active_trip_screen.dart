import 'package:flutter/material.dart';

import '../../data/trip.dart';
import '../../utils/app_localizations.dart';
import '../widgets/active_trip_numstops.dart';
import '../widgets/active_trip_stopwatch.dart';
import '../widgets/new_trip_button.dart';
import '../widgets/place_list_tile.dart';
import '../widgets/return_trip_button.dart';
import '../widgets/show_qr_button.dart';
import '../widgets/stop_trip_button.dart';

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
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                PlaceListTile(
                  activeTrip.source,
                  PlaceType.Source,
                ),
                PlaceListTile(
                  activeTrip.destination,
                  PlaceType.Destination,
                ),
                Card(
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.not_listed_location),
                      ],
                    ),
                    title: Text(AppLocalizations.of(context).reasonPickerDesc),
                    subtitle: Text(activeTrip.reason),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.exposure_plus_1),
                    title: Text(AppLocalizations.of(context).numStops),
                    trailing: ActiveTripNumStops(),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.access_time),
                    title: Text(AppLocalizations.of(context).elapsedTime),
                    trailing: ActiveTripStopwatch(),
                  ),
                ),
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

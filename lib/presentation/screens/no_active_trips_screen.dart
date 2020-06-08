import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';
import '../widgets/new_trip_button.dart';
import '../widgets/old_trips_button.dart';

class NoActiveTripsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Column(
              children: <Widget>[
                const Icon(Icons.home, size: 100),
                Text(
                  AppLocalizations.of(context).stayHome,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context).noActiveTrips,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            Spacer(),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              buttonPadding: const EdgeInsets.symmetric(horizontal: 40),
              children: <Widget>[
                NewTripButton(),
                OldTripsButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

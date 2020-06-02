import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';
import 'new_trip_screen.dart';
import 'old_trips_screen.dart';

class NoActiveTripsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Column(
              children: <Widget>[
                Icon(Icons.home, size: 100),
                Text(
                  AppLocalizations.of(context).stayHome,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    AppLocalizations.of(context).noActiveTrips,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            Spacer(),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              buttonPadding: EdgeInsets.symmetric(horizontal: 40),
              children: <Widget>[
                Tooltip(
                  message: AppLocalizations.of(context).newTrip,
                  preferBelow: false,
                  verticalOffset: 40,
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      NewTripScreen.routeName,
                    ),
                  ),
                ),
                Tooltip(
                  message: AppLocalizations.of(context).oldTrips,
                  preferBelow: false,
                  verticalOffset: 40,
                  child: FloatingActionButton(
                    child: Icon(Icons.history),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      OldTripsScreen.routeName,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:covtrack/presentation/screens/trip_details_screen.dart';
import 'package:flutter/material.dart';

import '../../data/trip.dart';
import '../../utils/app_localizations.dart';

class OldTripListTile extends StatelessWidget {
  final Trip trip;

  const OldTripListTile(this.trip, {Key key})
      : assert(trip != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        TripDetailsScreen.routeName,
        arguments: trip.destination,
      ),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(Icons.history),
              ),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: AppLocalizations.of(context).source,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' '),
                          TextSpan(text: trip.source.formattedAddress),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: AppLocalizations.of(context).destination,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' '),
                          TextSpan(text: trip.destination.formattedAddress),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

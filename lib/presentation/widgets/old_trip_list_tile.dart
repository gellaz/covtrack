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
    return Card(
      child: Row(
        children: <Widget>[
          Icon(Icons.history),
          Column(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context).source + ':',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: trip.source.formattedAddress)
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context).destination + ':',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: trip.destination.formattedAddress)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

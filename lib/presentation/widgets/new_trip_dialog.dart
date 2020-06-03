import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/trips/trips_bloc.dart';
import '../../data/trip.dart';
import '../../utils/app_localizations.dart';
import '../screens/new_trip_screen.dart';

class NewTripDialog extends StatelessWidget {
  final Trip activeTrip;

  const NewTripDialog(this.activeTrip, {Key key})
      : assert(activeTrip != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).newTripDialogTitle),
      content: Text(AppLocalizations.of(context).newTripDialogContent),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).yes),
          onPressed: () {
            context.bloc<TripsBloc>()
              ..add(TripUpdated(
                  activeTrip.copyWith(arrivalTime: DateTime.now())));
            Navigator.of(context).pushNamed(NewTripScreen.routeName);
          },
        ),
        FlatButton(
            child: Text(AppLocalizations.of(context).no),
            onPressed: () => Navigator.of(context).pop()),
      ],
    );
  }
}

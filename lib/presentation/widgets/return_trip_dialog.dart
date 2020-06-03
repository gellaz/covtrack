import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/trips/trips_bloc.dart';
import '../../data/trip.dart';
import '../../utils/app_localizations.dart';

class ReturnTripDialog extends StatelessWidget {
  final Trip activeTrip;

  const ReturnTripDialog(this.activeTrip, {Key key})
      : assert(activeTrip != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).returnTripDialogTitle),
      content: Text(AppLocalizations.of(context).returnTripDialogContent),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).yes),
          onPressed: () {
            context.bloc<TripsBloc>()
              ..add(
                  TripUpdated(activeTrip.copyWith(arrivalTime: DateTime.now())))
              ..add(TripAdded(activeTrip.returnTrip()));
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(AppLocalizations.of(context).no),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

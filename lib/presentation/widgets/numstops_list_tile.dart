import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/stops_tracker/stops_tracker_bloc.dart';
import '../../utils/app_localizations.dart';

class NumStopsListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Icon(
          Icons.exposure_plus_1,
          color: Theme.of(context).accentColor,
        ),
        title: Text(AppLocalizations.of(context).numStops),
        trailing: BlocBuilder<StopsTrackerBloc, StopsTrackerState>(
          builder: (_, state) {
            return Text(
              '${state.stops.length}',
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            );
          },
        ),
      ),
    );
  }
}

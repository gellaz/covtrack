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
        leading: const Icon(Icons.exposure_plus_1),
        title: Text(AppLocalizations.of(context).numStops),
        trailing: BlocBuilder<StopsTrackerBloc, StopsTrackerState>(
          builder: (_, state) {
            return Text('${state.stops.length}');
          },
        ),
      ),
    );
  }
}

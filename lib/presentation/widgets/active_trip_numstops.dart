import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/stops_tracker/stops_tracker_bloc.dart';

class ActiveTripNumStops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StopsTrackerBloc, StopsTrackerState>(
      builder: (_, state) {
        return Text('${state.stops.length}');
      },
    );
  }
}

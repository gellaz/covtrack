import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/stopwatch/stopwatch_bloc.dart';

class ActiveTripStopwatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StopwatchBloc, StopwatchState>(
      builder: (_, state) {
        final Duration elapsedTime = state.elapsedTime;
        final String secondsStr =
            (elapsedTime.inSeconds % 60).toString().padLeft(2, '0');
        final String minutesStr =
            (elapsedTime.inMinutes % 60).toString().padLeft(2, '0');
        final String hoursStr =
            (elapsedTime.inHours).toString().padLeft(2, '0');

        return Text('$hoursStr:$minutesStr:$secondsStr');
      },
    );
  }
}

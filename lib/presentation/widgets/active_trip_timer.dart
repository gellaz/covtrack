import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/timer/timer_bloc.dart';

class ActiveTripTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        final String hoursStr =
            (state.duration / 3600).floor().toString().padLeft(2, '0');
        final String minutesStr =
            ((state.duration / 60) % 60).floor().toString().padLeft(2, '0');
        final String secondsStr =
            (state.duration % 60).floor().toString().padLeft(2, '0');
        return Text('$hoursStr:$minutesStr:$secondsStr');
      },
    );
  }
}

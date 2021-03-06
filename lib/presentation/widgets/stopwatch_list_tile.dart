import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/stopwatch/stopwatch_bloc.dart';
import '../../utils/app_localizations.dart';

class StopwatchListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Icon(
          Icons.access_time,
          color: Theme.of(context).accentColor,
        ),
        title: Text(
          AppLocalizations.of(context).elapsedTime,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: BlocBuilder<StopwatchBloc, StopwatchState>(
          builder: (_, state) {
            final Duration elapsedTime = state.elapsedTime;
            final String secondsStr =
                (elapsedTime.inSeconds % 60).toString().padLeft(2, '0');
            final String minutesStr =
                (elapsedTime.inMinutes % 60).toString().padLeft(2, '0');
            final String hoursStr =
                (elapsedTime.inHours).toString().padLeft(2, '0');

            return Text(
              '$hoursStr:$minutesStr:$secondsStr',
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            );
          },
        ),
      ),
    );
  }
}

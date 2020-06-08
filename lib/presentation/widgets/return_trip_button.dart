import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/stopwatch/stopwatch_bloc.dart';
import '../../business/blocs/trips/trips_bloc.dart';
import '../../data/trip.dart';
import '../../utils/app_localizations.dart';
import 'return_trip_dialog.dart';

class ReturnTripButton extends StatelessWidget {
  final Trip activeTrip;

  const ReturnTripButton({Key key, @required this.activeTrip})
      : assert(activeTrip != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: AppLocalizations.of(context).returnTrip,
      preferBelow: false,
      verticalOffset: 40,
      child: FloatingActionButton(
        child: const Icon(Icons.keyboard_return),
        onPressed: () => _onPressed(context),
      ),
    );
  }

  void _onPressed(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => MultiBlocProvider(
        child: ReturnTripDialog(activeTrip),
        providers: [
          BlocProvider.value(value: context.bloc<TripsBloc>()),
          BlocProvider.value(value: context.bloc<StopwatchBloc>()),
        ],
      ),
    );
  }
}

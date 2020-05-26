import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/timer/timer_bloc.dart';
import '../../business/blocs/trips/trips_bloc.dart';
import '../../business/ticker.dart';
import '../../data/models/trip.dart';
import '../../utils/app_localizations.dart';
import '../widgets/active_trip_timer.dart';
import '../widgets/logout_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(Ticker(), 10),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            LogoutButton(),
          ],
        ),
        body: BlocListener<TripsBloc, TripsState>(
          listener: (context, state) {
            if (state is TripsLoadFailure) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(state.message), Icon(Icons.error)],
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
            }
          },
          child: BlocBuilder<TripsBloc, TripsState>(
            builder: (context, state) {
              if (state is TripsLoadInProgress) {
                return _buildTripsLoadInProgress();
              }
              if (state is TripsLoadSuccess) {
                final trips = state.trips;
                final lastTrip = trips.last;

                if (trips.isNotEmpty && lastTrip.arrivalTime == null) {
                  final duration =
                      DateTime.now().difference(lastTrip.startingTime);
                  context.bloc<TimerBloc>().add(Start(duration.inSeconds));
                  return _buildTripsLoadSuccessActiveTrip(context, trips.last);
                } else {
                  return _buildTripsLoadSuccessNoActiveTrips(context);
                }
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTripsLoadInProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildTripsLoadSuccessActiveTrip(
    BuildContext context,
    Trip activeTrip,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(activeTrip.toString()),
            ActiveTripTimer(),
            FloatingActionButton.extended(
              icon: Icon(Icons.stop),
              label: Text('Stop Timer'),
              onPressed: () => context.bloc<TimerBloc>().add(Pause()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripsLoadSuccessNoActiveTrips(
    BuildContext context,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(Icons.home, size: 100),
                Text(
                  AppLocalizations.of(context).stayHome,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).noActiveTrips,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                FloatingActionButton.extended(
                  icon: Icon(Icons.add),
                  label: Text(AppLocalizations.of(context).newTrip),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/home/destination-picker'),
                ),
                SizedBox(height: 10),
                FloatingActionButton.extended(
                  icon: Icon(Icons.history),
                  label: Text(AppLocalizations.of(context).oldTrips),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/home/old-trips'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

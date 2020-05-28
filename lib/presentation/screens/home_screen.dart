import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/timer/timer_bloc.dart';
import '../../business/blocs/trips/trips_bloc.dart';
import '../../data/models/trip.dart';
import '../../utils/app_localizations.dart';
import '../widgets/active_trip_timer.dart';
import '../widgets/logout_button.dart';
import '../widgets/place_list_tile.dart';
import 'new_trip_screen.dart';
import 'old_trips_screen.dart';
import 'qr_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              if (trips.isNotEmpty && trips.last.arrivalTime == null) {
                final duration =
                    DateTime.now().difference(trips.last.startingTime);
                context.bloc<TimerBloc>()..add(Start(duration.inSeconds));
                return _buildTripsLoadSuccessActiveTrip(
                  context,
                  trips.last,
                );
              } else {
                return _buildTripsLoadSuccessNoActiveTrips(context);
              }
            }
            return Container();
          },
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
          children: <Widget>[
            Text(
              AppLocalizations.of(context).activeTrip,
              style: Theme.of(context).textTheme.headline5,
            ),
            Column(
              children: <Widget>[
                PlaceListTile(activeTrip.source, PlaceType.Source),
                PlaceListTile(activeTrip.destination, PlaceType.Destination),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).reasonPickerDesc,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(activeTrip.reason),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).numStops,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text('0'),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).elapsedTime,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                ActiveTripTimer(),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              buttonPadding: EdgeInsets.symmetric(horizontal: 20),
              children: <Widget>[
                Tooltip(
                  message: AppLocalizations.of(context).showQr,
                  preferBelow: false,
                  verticalOffset: 40,
                  child: FloatingActionButton(
                    child: Icon(Icons.stop),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      QrScreen.routeName,
                      arguments: activeTrip,
                    ),
                  ),
                ),
                Tooltip(
                  message: AppLocalizations.of(context).newTrip,
                  preferBelow: false,
                  verticalOffset: 40,
                  child: FloatingActionButton(
                    child: Icon(Icons.keyboard_return),
                    onPressed: () {},
                  ),
                ),
                Tooltip(
                  message: AppLocalizations.of(context).newTrip,
                  preferBelow: false,
                  verticalOffset: 40,
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {},
                  ),
                ),
              ],
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
                      Navigator.pushNamed(context, NewTripScreen.routeName),
                ),
                SizedBox(height: 10),
                FloatingActionButton.extended(
                  icon: Icon(Icons.history),
                  label: Text(AppLocalizations.of(context).oldTrips),
                  onPressed: () =>
                      Navigator.pushNamed(context, OldTripsScreen.routeName),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

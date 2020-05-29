import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/timer/timer_bloc.dart';
import '../../business/blocs/trips/trips_bloc.dart';
import '../../data/trip.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).activeTrip,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                PlaceListTile(
                  activeTrip.source,
                  PlaceType.Source,
                ),
                PlaceListTile(
                  activeTrip.destination,
                  PlaceType.Destination,
                ),
                Card(
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.not_listed_location),
                      ],
                    ),
                    title: Text(AppLocalizations.of(context).reasonPickerDesc),
                    subtitle: Text(activeTrip.reason),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.exposure_plus_1),
                    title: Text(AppLocalizations.of(context).numStops),
                    trailing: Text('0'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.access_time),
                    title: Text(AppLocalizations.of(context).elapsedTime),
                    trailing: ActiveTripTimer(),
                  ),
                ),
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
                  message: AppLocalizations.of(context).returnTrip,
                  preferBelow: false,
                  verticalOffset: 40,
                  child: FloatingActionButton(
                    child: Icon(Icons.keyboard_return),
                    onPressed: () {
                      context.bloc<TripsBloc>()
                        ..add(TripUpdated(
                            activeTrip.copyWith(arrivalTime: DateTime.now())))
                        ..add(TripAdded(activeTrip.returnTrip()));

                      Scaffold.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocalizations.of(context)
                                    .returnTripStarted),
                                Icon(Icons.check),
                              ],
                            ),
                          ),
                        );
                    },
                  ),
                ),
                Tooltip(
                  message: AppLocalizations.of(context).newTrip,
                  preferBelow: false,
                  verticalOffset: 40,
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      context.bloc<TripsBloc>()
                        ..add(TripUpdated(
                            activeTrip.copyWith(arrivalTime: DateTime.now())));
                      Navigator.of(context).pushNamed(NewTripScreen.routeName);
                    },
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
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(Icons.home, size: 100),
                Text(
                  AppLocalizations.of(context).stayHome,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    AppLocalizations.of(context).noActiveTrips,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              buttonPadding: EdgeInsets.symmetric(horizontal: 40),
              children: <Widget>[
                Tooltip(
                  message: AppLocalizations.of(context).newTrip,
                  preferBelow: false,
                  verticalOffset: 40,
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      NewTripScreen.routeName,
                    ),
                  ),
                ),
                Tooltip(
                  message: AppLocalizations.of(context).oldTrips,
                  preferBelow: false,
                  verticalOffset: 40,
                  child: FloatingActionButton(
                    child: Icon(Icons.history),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      OldTripsScreen.routeName,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

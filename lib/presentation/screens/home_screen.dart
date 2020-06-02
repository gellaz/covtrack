import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../business/blocs/location/location_bloc.dart';
import '../../business/blocs/timer/timer_bloc.dart';
import '../../business/blocs/trips/trips_bloc.dart';
import '../widgets/logout_button.dart';
import 'active_trip_screen.dart';
import 'no_active_trips_screen.dart';

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
              return Center(child: CircularProgressIndicator());
            }
            if (state is TripsLoadSuccess) {
              final trips = state.trips;

              if (trips.isNotEmpty && trips.last.arrivalTime == null) {
                final duration =
                    DateTime.now().difference(trips.last.startingTime);
                context.bloc<TimerBloc>()..add(Start(duration.inSeconds));
                return BlocProvider(
                  create: (context) =>
                      LocationBloc(Geolocator(), trips.last.stops.length)
                        ..add(LocationStarted()),
                  child: ActiveTripScreen(trips.last),
                );
              } else {
                return NoActiveTripsScreen();
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/stops_tracker/stops_tracker_bloc.dart';
import '../../business/blocs/stopwatch/stopwatch_bloc.dart';
import '../../business/blocs/trips/trips_bloc.dart';
import '../../business/repositories/location/location_repository.dart';
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

              if (trips.last.arrivalTime == null) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (_) => StopwatchBloc(
                        startingTime:
                            DateTime.now().difference(trips.last.startingTime),
                      )..add(Start()),
                    ),
                    BlocProvider(
                      create: (_) => StopsTrackerBloc(
                        locationRepository:
                            context.repository<LocationRepository>(),
                        stops: trips.last.stops,
                      )..add(StartTracking()),
                    ),
                  ],
                  child: ActiveTripScreen(trips.last),
                );
              } else {
                return NoActiveTripsScreen();
              }
            }
            if (state is TripsEmpty) {
              return NoActiveTripsScreen();
            }
            return Container();
          },
        ),
      ),
    );
  }
}

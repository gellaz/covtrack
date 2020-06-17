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
        actions: <Widget>[LogoutButton()],
      ),
      body: BlocConsumer<TripsBloc, TripsState>(
        listener: (context, state) {
          if (state is TripsLoadFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(state.message), Icon(Icons.error)],
                  ),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state is TripsLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is TripsLoadSuccessEmpty) {
            return NoActiveTripsScreen();
          }
          if (state is TripsLoadSuccessNotActive) {
            return NoActiveTripsScreen();
          }
          if (state is TripsLoadSuccessActive) {
            final activeTrip = state.trips.last;

            return MultiBlocProvider(
              child: ActiveTripScreen(activeTrip),
              providers: [
                BlocProvider.value(
                  value: context.bloc<TripsBloc>(),
                ),
                BlocProvider(
                  create: (_) =>
                      StopwatchBloc(startingTime: activeTrip.startingTime)
                        ..add(StopwatchStarted()),
                ),
                BlocProvider(
                  create: (_) => StopsTrackerBloc(
                    locationRepository:
                        context.repository<LocationRepository>(),
                    stops: activeTrip.stops,
                  )..add(StartTracking()),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

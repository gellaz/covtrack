import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/trips/trips_bloc.dart';
import '../../data/trip.dart';
import '../../utils/app_localizations.dart';
import '../widgets/old_trip_list_tile.dart';

class OldTripsScreen extends StatelessWidget {
  static const routeName = '/old-trips';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).oldTrips),
      ),
      body: BlocListener<TripsBloc, TripsState>(
        listener: (context, state) {
          if (state is TripsLoadFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context).tripsLoadFailure),
                      Icon(Icons.error),
                    ],
                  ),
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
              if (state.trips.isEmpty) {
                return _buildNoPreviousTrips(context);
              } else {
                return _buildTripsLoadSuccess(context, state.trips);
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

  Widget _buildNoPreviousTrips(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.do_not_disturb_alt,
              color: Theme.of(context).disabledColor,
              size: 150,
            ),
            Text(
              AppLocalizations.of(context).noPreviousTripsTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context).noPreviousTripsBody,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripsLoadSuccess(BuildContext context, List<Trip> trips) {
    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (BuildContext context, int index) {
        return OldTripListTile(trips.elementAt(index));
      },
    );
  }
}

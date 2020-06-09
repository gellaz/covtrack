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
                    children: [
                      Text(AppLocalizations.of(context).tripsLoadFailure),
                      Icon(Icons.error),
                    ],
                  ),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state is TripsLoadInProgress) {
            return _buildTripsLoadInProgress();
          }
          if (state is TripsEmpty) {
            return _buildNoPreviousTrips(context);
          }
          if (state is TripsLoadSuccess) {
            return _buildTripsLoadSuccess(context, state.trips);
          }
          return Container();
        },
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
      padding: const EdgeInsets.all(40),
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
            const SizedBox(height: 20),
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
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: trips.length,
            itemBuilder: (_, int index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: OldTripListTile(trips.reversed.elementAt(index)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              const Divider(),
              Text(
                AppLocalizations.of(context).tripsTotal(trips.length),
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

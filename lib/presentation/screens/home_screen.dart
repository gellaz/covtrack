import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/trips/trips_bloc.dart';
import '../../data/models/trip.dart';
import '../../utils/app_localizations.dart';
import '../widgets/logout_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          LogoutButton(),
        ],
      ),
      body: BlocBuilder<TripsBloc, TripsState>(
        builder: (context, state) {
          if (state is TripsLoadInProgress) {
            return _buildTripsLoadInProgress();
          }
          if (state is TripsLoadSuccess) {
            return _buildTripsLoadSuccess(context, state.trips);
          }
          if (state is TripsLoadFailure) {
            return _buildTripsLoadFailure(context);
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

  Widget _buildTripsLoadSuccess(BuildContext context, List<Trip> trips) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildContent(context),
            _buildTripsList(trips),
            _buildButtonBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTripsLoadFailure(BuildContext context) {
    return Center(
      child: Text('Failure'),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(Icons.home, size: 100),
        Text('Stay Home. Stay Safe.'),
        SizedBox(height: 10),
        Text(
          AppLocalizations.of(context).noActiveTrips,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildButtonBar(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildNewTripButton(context),
        SizedBox(height: 10),
        _buildOldTripsButton(context),
      ],
    );
  }

  Widget _buildNewTripButton(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text(AppLocalizations.of(context).newTrip),
      onPressed: () => Navigator.pushNamed(context, '/home/destination-picker'),
    );
  }

  Widget _buildOldTripsButton(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.history),
      label: Text(AppLocalizations.of(context).oldTrips),
      onPressed: () => Navigator.pushNamed(context, '/home/old-trips'),
    );
  }

  Widget _buildTripsList(List<Trip> trips) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemBuilder: (context, index) => Text(trips[index].toString()),
        itemCount: trips.length,
      ),
    );
  }
}

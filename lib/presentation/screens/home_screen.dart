import 'package:flutter/material.dart';

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildContent(),
              _buildButtonBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        Icon(Icons.home, size: 100),
        Text('Stay Home. Stay Safe.'),
        SizedBox(height: 10),
        Text(
          'At the moment there is no active trip. If you need to go somewhere for a specific reason create a new trip or select one from the list of your previous trips.',
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
      label: Text('New Trip'),
      onPressed: () => Navigator.pushNamed(context, '/home/destination-picker'),
    );
  }

  Widget _buildOldTripsButton(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.history),
      label: Text('Old Trips'),
      onPressed: () => Navigator.pushNamed(context, '/home/old-trips'),
    );
  }
}

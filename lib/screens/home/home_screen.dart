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
          'At the moment there is no active displacement. If you need to go somewhere for a specific reason start create a new displacement or select one from the list of your previous displacements.',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildButtonBar(BuildContext context) {
    return Column(
      children: <Widget>[
        FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(
            context,
            '/home/place-picker',
          ),
          label: Text('New Trip'),
          icon: Icon(Icons.add),
        ),
        SizedBox(height: 10),
        FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(
            context,
            '/home/old-trips',
          ),
          label: Text('Old Trips'),
          icon: Icon(Icons.history),
        ),
      ],
    );
  }
}

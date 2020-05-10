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
        child: Text('Home'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/home/place-picker'),
        label: Text('Pick a place'),
      ),
    );
  }
}

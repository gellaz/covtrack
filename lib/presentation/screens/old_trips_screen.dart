import 'package:flutter/material.dart';

class OldTripsScreen extends StatelessWidget {
  static const routeName = '/old-trips';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Old Trips'),
      ),
      body: Center(
        child: Text('Old Trips'),
      ),
    );
  }
}

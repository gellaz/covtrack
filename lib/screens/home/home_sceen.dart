import 'package:covtrack/screens/widgets/log_out_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          LogOutButton(),
        ],
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}

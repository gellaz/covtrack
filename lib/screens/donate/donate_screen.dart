import 'package:covtrack/screens/widgets/log_out_button.dart';
import 'package:flutter/material.dart';

class DonateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate'),
        actions: <Widget>[
          LogOutButton(),
        ],
      ),
      body: Center(
        child: Text('Donate'),
      ),
    );
  }
}

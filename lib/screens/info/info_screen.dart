import 'package:flutter/material.dart';

import '../widgets/logout_button.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
        actions: <Widget>[
          LogoutButton(),
        ],
      ),
      body: Center(
        child: Text('Info'),
      ),
    );
  }
}

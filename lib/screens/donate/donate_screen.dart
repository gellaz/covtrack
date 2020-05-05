import 'package:flutter/material.dart';

import '../widgets/logout_button.dart';

class DonateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate'),
        actions: <Widget>[
          LogoutButton(),
        ],
      ),
      body: Center(
        child: Text('Donate'),
      ),
    );
  }
}

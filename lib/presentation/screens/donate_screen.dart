import 'package:covtrack/utils/app_localizations.dart';
import 'package:flutter/material.dart';

import '../widgets/logout_button.dart';

class DonateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).donate),
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

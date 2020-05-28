import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';
import '../widgets/logout_button.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings),
        actions: <Widget>[
          LogoutButton(),
        ],
      ),
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}

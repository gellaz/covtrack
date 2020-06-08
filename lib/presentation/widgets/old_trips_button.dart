import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';
import '../screens/old_trips_screen.dart';

class OldTripsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: AppLocalizations.of(context).oldTrips,
      preferBelow: false,
      verticalOffset: 40,
      child: FloatingActionButton(
        child: const Icon(Icons.history),
        onPressed: () => _onPressed(context),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.pushNamed(
      context,
      OldTripsScreen.routeName,
    );
  }
}

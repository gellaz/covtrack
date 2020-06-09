import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';
import '../screens/destination_picker_screen.dart';

class NewTripButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: AppLocalizations.of(context).newTrip,
      preferBelow: false,
      verticalOffset: 40,
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _onPressed(context),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.pushNamed(
      context,
      DestinationPickerScreen.routeName,
    );
  }
}

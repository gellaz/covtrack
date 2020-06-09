import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';

class StartTripButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartTripButton({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(AppLocalizations.of(context).startTrip),
          const Icon(Icons.keyboard_arrow_right),
        ],
      ),
    );
  }
}

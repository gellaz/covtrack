import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/trip.dart';
import '../../utils/app_localizations.dart';
import '../screens/qr_screen.dart';

class ShowQrButton extends StatelessWidget {
  final Trip activeTrip;

  const ShowQrButton({Key key, @required this.activeTrip})
      : assert(activeTrip != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: AppLocalizations.of(context).showQr,
      preferBelow: false,
      verticalOffset: 40,
      child: FloatingActionButton(
        child: const Icon(FontAwesomeIcons.qrcode),
        onPressed: () => _onPressed(context),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.pushNamed(
      context,
      QrScreen.routeName,
      arguments: activeTrip,
    );
  }
}

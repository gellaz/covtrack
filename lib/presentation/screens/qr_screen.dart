import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../data/trip.dart';

class QrScreen extends StatelessWidget {
  static const routeName = '/qr';

  final Trip activeTrip;

  const QrScreen(this.activeTrip, {Key key})
      : assert(activeTrip != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: QrImage(
            data: activeTrip.toString(),
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(20),
            version: QrVersions.auto,
            size: 300,
          ),
        ),
      ),
    );
  }
}

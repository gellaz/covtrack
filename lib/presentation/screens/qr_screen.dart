import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../business/blocs/authentication/authentication_bloc.dart';
import '../../data/trip.dart';

class QrScreen extends StatelessWidget {
  static const routeName = '/qr';

  final Trip activeTrip;

  const QrScreen(this.activeTrip, {Key key})
      : assert(activeTrip != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (_, state) {
        if (state is Authenticated) {
          return Scaffold(
            appBar: AppBar(elevation: 0),
            body: Container(
              color: Theme.of(context).primaryColor,
              child: Center(
                child: QrImage(
                  data: state.user.uid + '-' + activeTrip.tripId,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.all(20),
                  version: QrVersions.auto,
                  size: 300,
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

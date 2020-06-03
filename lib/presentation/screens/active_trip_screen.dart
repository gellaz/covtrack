import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../business/blocs/location/location_bloc.dart';
import '../../data/trip.dart';
import '../../utils/app_localizations.dart';
import '../widgets/active_trip_timer.dart';
import '../widgets/new_trip_dialog.dart';
import '../widgets/place_list_tile.dart';
import '../widgets/return_trip_dialog.dart';
import '../widgets/stop_trip_dialog.dart';
import 'qr_screen.dart';

class ActiveTripScreen extends StatelessWidget {
  final Trip activeTrip;

  const ActiveTripScreen(this.activeTrip, {Key key})
      : assert(activeTrip != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationInitial) {
          return Center(child: Text('Fetching Location'));
        }
        if (state is LocationLoadSuccess) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).activeTrip,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      PlaceListTile(
                        activeTrip.source,
                        PlaceType.Source,
                      ),
                      PlaceListTile(
                        activeTrip.destination,
                        PlaceType.Destination,
                      ),
                      Card(
                        child: ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.not_listed_location),
                            ],
                          ),
                          title: Text(
                              AppLocalizations.of(context).reasonPickerDesc),
                          subtitle: Text(activeTrip.reason),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.exposure_plus_1),
                          title: Text(AppLocalizations.of(context).numStops),
                          trailing: Text(state.numStops.toString()),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.access_time),
                          title: Text(AppLocalizations.of(context).elapsedTime),
                          trailing: ActiveTripTimer(),
                        ),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    buttonPadding: EdgeInsets.symmetric(horizontal: 20),
                    children: <Widget>[
                      Tooltip(
                        message: AppLocalizations.of(context).showQr,
                        preferBelow: false,
                        verticalOffset: 40,
                        child: FloatingActionButton(
                          child: Icon(FontAwesomeIcons.qrcode),
                          onPressed: () => Navigator.pushNamed(
                            context,
                            QrScreen.routeName,
                            arguments: activeTrip,
                          ),
                        ),
                      ),
                      Tooltip(
                        message: AppLocalizations.of(context).stopTrip,
                        preferBelow: false,
                        verticalOffset: 40,
                        child: FloatingActionButton(
                          child: Icon(Icons.stop),
                          onPressed: () async => showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => StopTripDialog(activeTrip),
                          ),
                        ),
                      ),
                      Tooltip(
                        message: AppLocalizations.of(context).returnTrip,
                        preferBelow: false,
                        verticalOffset: 40,
                        child: FloatingActionButton(
                          child: Icon(Icons.keyboard_return),
                          onPressed: () async => showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => ReturnTripDialog(activeTrip),
                          ),
                        ),
                      ),
                      Tooltip(
                        message: AppLocalizations.of(context).newTrip,
                        preferBelow: false,
                        verticalOffset: 40,
                        child: FloatingActionButton(
                          child: Icon(Icons.add),
                          onPressed: () async => showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => NewTripDialog(activeTrip),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../../data/old_destination.dart';
import '../screens/trip_details_screen.dart';

class OldDestinationListTile extends StatelessWidget {
  final OldDestination oldDestination;

  const OldDestinationListTile({Key key, @required this.oldDestination})
      : assert(oldDestination != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.history),
          ],
        ),
        title: Text(
          oldDestination.place.mainText,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(oldDestination.place.secondaryText),
        trailing: Text(oldDestination.numVisits.toString()),
        onTap: () => _onTap(context),
      ),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.pushNamed(
      context,
      TripDetailsScreen.routeName,
      arguments: oldDestination.place,
    );
  }
}

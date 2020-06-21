import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/old_destinations/old_destinations_bloc.dart';
import '../../data/old_destination.dart';
import '../../utils/app_localizations.dart';
import '../widgets/old_destination_list_tile.dart';

class OldDestinationsScreen extends StatelessWidget {
  static const routeName = '/old-destinations';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).oldDestinations),
      ),
      body: BlocConsumer<OldDestinationsBloc, OldDestinationsState>(
        listener: (context, state) {
          if (state is OldDestinationsLoadFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)
                          .oldDestinationsLoadFailure),
                      const Icon(Icons.error),
                    ],
                  ),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state is OldDestinationsLoadInProgress) {
            return _buildOldDestinationsLoadInProgress();
          }
          if (state is OldDestinationsLoadSuccessEmpty) {
            return _buildNoPreviousOldDestinations(context);
          }
          if (state is OldDestinationsLoadSuccess) {
            return _buildOldDestinationsLoadSuccess(
              context,
              state.oldDestinations,
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildOldDestinationsLoadInProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildNoPreviousOldDestinations(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.do_not_disturb_alt,
              color: Theme.of(context).disabledColor,
              size: 150,
            ),
            Text(
              AppLocalizations.of(context).noPreviousTripsTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context).noPreviousTripsBody,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOldDestinationsLoadSuccess(
    BuildContext context,
    List<OldDestination> oldDestinations,
  ) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: oldDestinations.length,
            itemBuilder: (_, int index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: OldDestinationListTile(
                oldDestination: oldDestinations.elementAt(index),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              const Divider(),
              Text(
                AppLocalizations.of(context).tripsTotal(oldDestinations.length),
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

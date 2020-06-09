import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/trip_details/trip_details_bloc.dart';
import '../../business/blocs/trips/trips_bloc.dart';
import '../../business/repositories/location/location_repository.dart';
import '../../business/repositories/places/places_repository.dart';
import '../../data/place.dart';
import '../../data/trip.dart';
import '../../utils/app_localizations.dart';
import '../widgets/destination_list_tile.dart';
import '../widgets/reason_dropdown.dart';
import '../widgets/source_list_tile.dart';

class TripDetailsScreen extends StatefulWidget {
  static const routeName = '/trip-details';

  final Place destination;

  const TripDetailsScreen(this.destination, {Key key})
      : assert(destination != null),
        super(key: key);

  @override
  _TripDetailsScreenState createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  String selectedReason;

  bool isStartTripButtonEnabled() => selectedReason != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TripDetailsBloc(
        locationRepository: context.repository<LocationRepository>(),
        placesRepository: context.repository<PlacesRepository>(),
      )..add(LoadCurrentPlace()),
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context).tripDetails)),
        body: MultiBlocListener(
          listeners: [
            BlocListener<TripsBloc, TripsState>(
              listener: (context, state) {
                if (state is TripsLoadSuccessActive) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
              },
            ),
            BlocListener<TripDetailsBloc, TripDetailsState>(
              listener: (context, state) {
                if (state is UserPlaceError) {
                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Error'), Icon(Icons.error)],
                        ),
                      ),
                    );
                }
              },
            ),
          ],
          child: BlocBuilder<TripDetailsBloc, TripDetailsState>(
            builder: (_, state) {
              if (state is UserPlaceLoading) {
                return _buildLoading();
              }
              if (state is UserPlaceSuccess) {
                return _buildSuccess(context, state.place);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildSuccess(BuildContext context, Place source) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).source,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SourceListTile(source: source),
                    buildDivider(),
                    Text(
                      AppLocalizations.of(context).destination,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    DestinationListTile(destination: widget.destination),
                    buildDivider(),
                    Text(
                      AppLocalizations.of(context).reasonPickerDesc,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    ReasonDropdown(
                      onReasonSelected: onReasonSelected,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FloatingActionButton.extended(
              icon: const Icon(Icons.keyboard_arrow_right),
              label: Text(AppLocalizations.of(context).startTrip),
              onPressed: isStartTripButtonEnabled()
                  ? () => onPressed(context, source)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Padding buildDivider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: const Divider(thickness: 1),
    );
  }

  void onPressed(BuildContext context, Place source) {
    context.bloc<TripsBloc>().add(
          AddTrip(
            Trip(
              tripId: null,
              reason: selectedReason,
              startingTime: DateTime.now(),
              arrivalTime: null,
              source: source,
              destination: widget.destination,
              stops: [],
            ),
          ),
        );
  }

  void onReasonSelected(String newReason) {
    setState(() => selectedReason = newReason);
  }
}

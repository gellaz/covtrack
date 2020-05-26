import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../business/blocs/trips/trips_bloc.dart';
import '../../business/repositories/location/location_repository.dart';
import '../../business/repositories/places/places_repository.dart';
import '../../data/models/place.dart';
import '../../data/models/trip.dart';
import '../../utils/app_localizations.dart';
import '../widgets/place_list_tile.dart';
import '../widgets/reason_picker.dart';

const List<String> reasonsList = [
  'Comprovate esigenze lavorative',
  'Situazioni di necessità',
  'Motivi di salute'
];

class TripDetailsScreen extends StatefulWidget {
  final Place destination;

  const TripDetailsScreen(this.destination, {Key key})
      : assert(destination != null),
        super(key: key);

  @override
  _TripDetailsScreenState createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  GoogleMapController _mapController;
  LocationRepository _locationRepository;
  PlacesRepository _placesRepository;
  Future<Place> _futureSource;
  Place _source;
  // this set will hold my markers
  Set<Marker> _markers = {};
  // this will hold the generated polylines
  Set<Polyline> _polylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  String _selectedReason;

  @override
  void initState() {
    super.initState();
    _locationRepository = context.repository<LocationRepository>();
    _placesRepository = context.repository<PlacesRepository>();
    _futureSource = _getCurrentPlace();
    _setSourceAndDestinationIcons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).tripDetails),
      ),
      body: FutureBuilder<Place>(
        future: _futureSource,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _source = snapshot.data;
            return ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).source,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    PlaceListTile(snapshot.data, PlaceType.Home),
                    Text(
                      AppLocalizations.of(context).destination,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    PlaceListTile(widget.destination, PlaceType.Destination),
                    SizedBox(height: 10),
                    Container(
                      height: 300,
                      child: GoogleMap(
                        compassEnabled: false,
                        gestureRecognizers: null,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            snapshot.data.latitude,
                            snapshot.data.longitude,
                          ),
                          zoom: 16,
                        ),
                        mapToolbarEnabled: false,
                        mapType: MapType.normal,
                        markers: _markers,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: false,
                        onMapCreated: _onMapCreated,
                        polylines: _polylines,
                        scrollGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        trafficEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context).reasonPickerDesc,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 10),
                    ReasonPicker(reasonsList, _onReasonSelected),
                  ],
                ),
                FloatingActionButton.extended(
                  icon: Icon(Icons.keyboard_arrow_right),
                  label: Text(AppLocalizations.of(context).startTrip),
                  onPressed: () => _onPressed(context),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Error'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            return null;
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<Place> _getCurrentPlace() async {
    final coordsMap = await _locationRepository.getCurrentLocation();
    return await _placesRepository.getPlaceFromCoords(
      coordsMap['latitude'],
      coordsMap['longitude'],
    );
  }

  void _onMapCreated(GoogleMapController mapController) {
    _mapController = mapController;
    _setMarkers();
    _setPolylines();
  }

  void _onPressed(BuildContext context) {
    context.bloc<TripsBloc>().add(
          TripAdded(
            Trip(
              reason: _selectedReason,
              startingTime: DateTime.now(),
              arrivalTime: null,
              source: widget.destination,
              destination: widget.destination,
            ),
          ),
        );
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _onReasonSelected(int index) {
    setState(() {
      _selectedReason = reasonsList.elementAt(index);
    });
  }

  void _setMarkers() {
    setState(() {
      // Source marker
      _markers.add(
        Marker(
          markerId: MarkerId('sourceMarker'),
          position: LatLng(
            _source.latitude,
            _source.longitude,
          ),
          icon: sourceIcon,
        ),
      );
      // Destination marker
      _markers.add(
        Marker(
          markerId: MarkerId('destMarker'),
          position: LatLng(
            widget.destination.latitude,
            widget.destination.longitude,
          ),
          icon: destinationIcon,
        ),
      );
    });
  }

  void _setPolylines() async {
    final result = await polylinePoints?.getRouteBetweenCoordinates(
      'AIzaSyC31XYERPq-Iy_kke7gkN_BB5DHGcSSncI',
      PointLatLng(
        _source.latitude,
        _source.longitude,
      ),
      PointLatLng(
        widget.destination.latitude,
        widget.destination.longitude,
      ),
    );
    if (result.points.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId('poly'),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }

  void _setSourceAndDestinationIcons() {
    sourceIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueBlue,
    );
    destinationIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueOrange,
    );
  }
}

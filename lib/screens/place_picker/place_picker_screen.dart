import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/place.dart';
import 'places_search_field.dart';

class PlacePickerScreen extends StatefulWidget {
  @override
  _PlacePickerScreenState createState() => _PlacePickerScreenState();
}

class _PlacePickerScreenState extends State<PlacePickerScreen> {
  GoogleMapController _mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController mapController) {
    _mapController = mapController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PlacesSearchField(
          centerMapOn: _centerMapOn,
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11,
        ),
        mapType: MapType.normal,
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
      ),
    );
  }

  void _centerMapOn(Place place) {
    final _selectedDestination = CameraPosition(
      target: LatLng(place.latitude, place.longitude),
      zoom: 16,
    );

    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(_selectedDestination),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/place.dart';
import '../widgets/places_search_field.dart';

class HomeDetailScreen extends StatefulWidget {
  @override
  _HomeDetailScreenState createState() => _HomeDetailScreenState();
}

class _HomeDetailScreenState extends State<HomeDetailScreen> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11,
            ),
            onMapCreated: _onMapCreated,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: PlacesSearchField(centerMapOn: _centerMapOn),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Row(
          children: <Widget>[
            FloatingActionButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back),
            ),
          ],
        ),
      ),
    );
  }

  void _centerMapOn(Place place) {
    final _selectedDestination = CameraPosition(
      target: LatLng(place.latitude, place.longitude),
      zoom: 16,
    );

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(_selectedDestination),
    );
  }
}

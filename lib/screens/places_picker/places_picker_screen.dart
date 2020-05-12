import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/coordinates.dart';
import '../../models/place.dart';
import '../../services/location/location_service.dart';
import '../../services/places/places_service.dart';

// TODO: Handle latitude called on null exception.
// TODO: Overwrite search bar text with address of marker.

class PlacesPickerScreen extends StatefulWidget {
  @override
  _PlacesPickerScreenState createState() => _PlacesPickerScreenState();
}

class _PlacesPickerScreenState extends State<PlacesPickerScreen> {
  LatLng _userLocation;
  GoogleMapController _mapController;
  LocationService _locationService;
  Marker _marker;
  PlacesService _placesService;

  @override
  void initState() {
    super.initState();
    _locationService = RepositoryProvider.of<LocationService>(context);
    _placesService = RepositoryProvider.of<PlacesService>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places Picker'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
        mapType: MapType.normal,
        markers: _marker != null ? {_marker} : null,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: _onMapCreated,
        onTap: _onTap,
      ),
    );
  }

  void _addMarker(LatLng location, Place place) {
    final markerId = MarkerId(place.placeId);
    setState(() {
      _marker = Marker(
        infoWindow: InfoWindow(
          title: '${place.mainText}',
          snippet: '${place.secondaryText}',
        ),
        markerId: markerId,
        position: location,
      );
    });
  }

  void _centerMapOn(LatLng location) {
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        location,
        16,
      ),
    );
  }

  Future<Place> _getLocationDetails(LatLng location) async {
    final coords = Coordinates(
      location.latitude,
      location.longitude,
    );
    final placeId = await _placesService.getPlaceId(coords);
    return await _placesService.getDetails(placeId);
  }

  void _onMapCreated(GoogleMapController mapController) {
    _locationService.getCurrentLocation().then((coords) {
      setState(() {
        _userLocation = LatLng(
          coords.latitude,
          coords.longitude,
        );
      });
      _mapController = mapController;
      _centerMapOn(_userLocation);
    });
  }

  void _onTap(LatLng location) async {
    final place = await _getLocationDetails(location);
    _addMarker(location, place);
    _centerMapOn(location);
  }
}

import 'package:covtrack/screens/places_picker/places_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/place.dart';
import '../../services/location/location_service.dart';
import '../../services/places/places_service.dart';
import 'destination_card.dart';

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
  Widget _detailCard;

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
        title: _userLocation != null
            ? PlacesSearchField(
                _userLocation.latitude,
                _userLocation.longitude,
                _onTap,
              )
            : null,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
        mapType: MapType.normal,
        markers: _marker != null ? {_marker} : null,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: _onMapCreated,
        onTap: _onTap,
        zoomControlsEnabled: false,
      ),
      floatingActionButton: _detailCard,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _addMarker(LatLng location) {
    final markerId = MarkerId(location.toString());
    setState(() {
      _marker = Marker(
        markerId: markerId,
        position: location,
      );
    });
  }

  void _buildDestinationCard(Place destination) {
    setState(() {
      _detailCard = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DestinationCard(destination),
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
    final placeId = await _placesService.getPlaceId(
      location.latitude,
      location.longitude,
    );
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
    _addMarker(location);
    _centerMapOn(location);
    final place = await _getLocationDetails(location);
    _buildDestinationCard(place);
  }
}

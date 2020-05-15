import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/place.dart';
import '../../repositories/location/location_repository.dart';
import '../../repositories/places/places_repository.dart';
import 'destination_card.dart';
import 'places_search_field.dart';

class PlacesPickerScreen extends StatefulWidget {
  @override
  _PlacesPickerScreenState createState() => _PlacesPickerScreenState();
}

class _PlacesPickerScreenState extends State<PlacesPickerScreen> {
  LatLng _userLocation;
  GoogleMapController _mapController;
  LocationRepository _locationRepository;
  Marker _marker;
  PlacesRepository _placesRepository;
  Widget _detailCard;

  @override
  void initState() {
    super.initState();
    _locationRepository = RepositoryProvider.of<LocationRepository>(context);
    _placesRepository = RepositoryProvider.of<PlacesRepository>(context);
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
    final placeId = await _placesRepository.getPlaceId(
      location.latitude,
      location.longitude,
    );
    return await _placesRepository.getDetails(placeId);
  }

  void _onMapCreated(GoogleMapController mapController) {
    _locationRepository.getCurrentLocation().then((coords) {
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../business/repositories/location/location_repository.dart';
import '../../business/repositories/places/places_repository.dart';
import '../../data/place.dart';
import '../widgets/destination_card.dart';
import '../widgets/places_search_field.dart';
import 'trip_details_screen.dart';

class NewTripScreen extends StatefulWidget {
  static const routeName = '/new-trip';

  @override
  _NewTripScreenState createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  LatLng _userLocation;
  GoogleMapController _mapController;
  LocationRepository _locationRepository;
  Marker _marker;
  PlacesRepository _placesRepository;
  Widget _detailCard;
  Place _selectedPlace;

  @override
  void initState() {
    super.initState();
    _locationRepository = context.repository<LocationRepository>();
    _placesRepository = context.repository<PlacesRepository>();
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
                selectedPlace: _selectedPlace,
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
        child: DestinationCard(
            place: destination,
            onButtonPressed: () {
              Navigator.pushNamed(
                context,
                TripDetailsScreen.routeName,
                arguments: destination,
              );
            }),
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
    return await _placesRepository.getPlaceFromCoords(
      location.latitude,
      location.longitude,
    );
  }

  void _onMapCreated(GoogleMapController mapController) {
    _locationRepository.currentLocation.then((coords) {
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
    setState(() {
      _selectedPlace = place;
    });
    _buildDestinationCard(place);
  }
}

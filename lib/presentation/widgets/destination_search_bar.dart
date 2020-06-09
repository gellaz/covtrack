import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../business/repositories/places/places_repository.dart';
import '../../data/place.dart';
import '../../data/place_suggestion.dart';
import '../../utils/app_localizations.dart';
import 'place_suggestion_list_tile.dart';

class DestinationSearchBar extends StatefulWidget {
  final Function addMarkerAndCenterMapOn;
  final double userLatitude;
  final double userLongitude;
  final Place selectedPlace;

  const DestinationSearchBar(
      this.userLatitude, this.userLongitude, this.addMarkerAndCenterMapOn,
      {this.selectedPlace, Key key})
      : assert(addMarkerAndCenterMapOn != null),
        assert(userLatitude != null),
        assert(userLongitude != null),
        super(key: key);

  @override
  _DestinationSearchBarState createState() => _DestinationSearchBarState();
}

class _DestinationSearchBarState extends State<DestinationSearchBar> {
  final TextEditingController _controller = TextEditingController();
  PlacesRepository _placesRepository;

  @override
  void initState() {
    super.initState();
    _placesRepository = context.repository<PlacesRepository>();
    _controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.selectedPlace?.formattedAddress ?? '';

    return TypeAheadField(
      itemBuilder: _itemBuilder,
      onSuggestionSelected: _onSuggestionSelected,
      suggestionsCallback: _suggestionsCallback,
      hideOnEmpty: true,
      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 10,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          hintText: AppLocalizations.of(context).insertDestination,
          suffixIcon: IconButton(icon: Icon(Icons.clear), onPressed: _onClear),
        ),
        textInputAction: TextInputAction.none,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _itemBuilder(_, PlaceSuggestion suggestion) {
    return PlaceSuggestionListTile(suggestion);
  }

  void _onClear() {
    _controller.text = '';
  }

  void _onSuggestionSelected(PlaceSuggestion suggestion) async {
    Place place = await _placesRepository.getPlaceFromSuggestion(suggestion);

    _setText(place.formattedAddress);
    widget.addMarkerAndCenterMapOn(
      LatLng(
        place.coords.latitude,
        place.coords.longitude,
      ),
    );
  }

  void _setText(String text) {
    _controller.text = text;
  }

  Future<List<PlaceSuggestion>> _suggestionsCallback(String input) async {
    return await _placesRepository.getSuggestions(
      input,
      widget.userLatitude,
      widget.userLongitude,
    );
  }
}

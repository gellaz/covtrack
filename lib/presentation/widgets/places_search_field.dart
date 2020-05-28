import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../business/repositories/places/places_repository.dart';
import '../../data/models/place.dart';
import '../../data/models/place_suggestion.dart';
import '../../utils/app_localizations.dart';
import 'clear_button.dart';
import 'place_suggestion_list_tile.dart';

class PlacesSearchField extends StatefulWidget {
  final Function addMarkerAndCenterMapOn;
  final double userLatitude;
  final double userLongitude;
  final Place selectedPlace;

  const PlacesSearchField(
      this.userLatitude, this.userLongitude, this.addMarkerAndCenterMapOn,
      {this.selectedPlace, Key key})
      : assert(addMarkerAndCenterMapOn != null),
        assert(userLatitude != null),
        assert(userLongitude != null),
        super(key: key);

  @override
  _PlacesSearchFieldState createState() => _PlacesSearchFieldState();
}

class _PlacesSearchFieldState extends State<PlacesSearchField> {
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
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
          hintText: AppLocalizations.of(context).insertPlace,
          suffixIcon: ClearButton(_onClear),
        ),
        style: TextStyle(color: Colors.white),
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
    final place = await _placesRepository.getPlaceFromSuggestion(suggestion);
    setText(place.formattedAddress);
    widget.addMarkerAndCenterMapOn(
      LatLng(
        place.latitude,
        place.longitude,
      ),
    );
  }

  void setText(String text) {
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

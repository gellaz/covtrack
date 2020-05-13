import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../models/place_suggestion.dart';
import '../../services/places/places_service.dart';
import 'clear_button.dart';
import 'place_suggestion_list_tile.dart';

class PlacesSearchField extends StatefulWidget {
  final double userLatitude;
  final double userLongitude;
  final Function addMarkerAndCenterMapOn;

  const PlacesSearchField(
      this.userLatitude, this.userLongitude, this.addMarkerAndCenterMapOn,
      {Key key})
      : assert(userLatitude != null),
        assert(userLongitude != null),
        assert(addMarkerAndCenterMapOn != null),
        super(key: key);

  @override
  _PlacesSearchFieldState createState() => _PlacesSearchFieldState();
}

class _PlacesSearchFieldState extends State<PlacesSearchField> {
  final _controller = TextEditingController();
  PlacesService _placesService;

  @override
  void initState() {
    super.initState();
    _placesService = RepositoryProvider.of<PlacesService>(context);
    _controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      itemBuilder: _itemBuilder,
      onSuggestionSelected: _onSuggestionSelected,
      suggestionsCallback: _suggestionsCallback,
      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
          hintText: 'Insert a place...',
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
    final place = await _placesService.getDetails(suggestion.placeId);
    widget.addMarkerAndCenterMapOn(place);
  }

  Future<List<PlaceSuggestion>> _suggestionsCallback(String input) async {
    return await _placesService.getSuggestions(
      input,
      widget.userLatitude,
      widget.userLongitude,
    );
  }
}

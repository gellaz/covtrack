import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../models/place_suggestion.dart';
import '../../services/places/places_service.dart';
import 'clear_button.dart';
import 'place_suggestion_list_tile.dart';

class PlacesSearchField extends StatefulWidget {
  final Function centerMapOn;

  const PlacesSearchField({Key key, @required this.centerMapOn})
      : assert(centerMapOn != null),
        super(key: key);

  @override
  _PlacesSearchFieldState createState() => _PlacesSearchFieldState();
}

class _PlacesSearchFieldState extends State<PlacesSearchField> {
  PlacesService _placesService;
  TextFieldConfiguration _textFieldConfiguration;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _placesService = RepositoryProvider.of<PlacesService>(context);
    _textFieldConfiguration = _buildConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      itemBuilder: _itemBuilder,
      textFieldConfiguration: _textFieldConfiguration,
      onSuggestionSelected: _onSuggestionSelected,
      suggestionsCallback: _suggestionsCallback,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _itemBuilder(BuildContext context, PlaceSuggestion placeSuggestion) {
    return PlaceSuggestionListTile(placeSuggestion: placeSuggestion);
  }

  void _onClear() {
    _controller.text = '';
  }

  void _onSuggestionSelected(PlaceSuggestion placeSuggestion) async {
    final place = await _placesService.fetchPlaceDetails(
      placeId: placeSuggestion.placeId,
    );
    widget.centerMapOn(place);
  }

  Future<List<PlaceSuggestion>> _suggestionsCallback(String input) async {
    return await _placesService.fetchSuggestions(input: input);
  }

  TextFieldConfiguration _buildConfiguration() {
    return TextFieldConfiguration(
      controller: _controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        fillColor: Colors.grey[850].withOpacity(0.8),
        filled: true,
        hintText: 'Insert a place...',
        prefixIcon: Icon(Icons.search, color: Colors.white),
        suffixIcon: ClearButton(onClear: _onClear),
      ),
      style: TextStyle(color: Colors.white),
      textInputAction: TextInputAction.none,
    );
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../models/place.dart';
import '../../models/place_suggestion.dart';

part 'google_places_service.dart';
part 'mock_places_service.dart';

abstract class PlacesService {
  Future<Place> fetchPlaceDetails({@required String placeId});
  Future<List<PlaceSuggestion>> fetchSuggestions({@required String input});
}

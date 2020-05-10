import 'package:google_maps_webservice/places.dart';

import '../../models/place.dart';
import '../../models/place_suggestion.dart';

part 'google_places_service.dart';

abstract class PlacesService {
  Future<Place> fetchPlaceDetails(String placeId);
  Future<List<PlaceSuggestion>> fetchPlaceSuggestions(String input);
}

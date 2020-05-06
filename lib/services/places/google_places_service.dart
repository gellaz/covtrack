part of 'places_service.dart';

class GooglePlacesService implements PlacesService {
  static const GOOGLE_API_KEY = 'AIzaSyC5k8IchkmGBB4bNVjkIpVjm_X-XVMEvXQ';
  static const AUTHORITY = 'maps.googleapis.com';
  static const AUTOCOMPLETE_UNENCODED_PATH =
      '/maps/api/place/autocomplete/json';
  static const DETAILS_UNENCODED_PATH = '/maps/api/place/details/json';

  @override
  Future<Place> fetchPlaceDetails({@required String placeId}) async {
    final queryParameters = {
      'key': GOOGLE_API_KEY,
      'place_id': placeId,
      'language': 'it',
      'fields': 'formatted_address,geometry,name,place_id',
    };
    final uri = Uri.https(
      AUTHORITY,
      DETAILS_UNENCODED_PATH,
      queryParameters,
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['result'] as Map<String, dynamic>;

      return Place.fromJson(result);
    } else {
      throw Exception('Failed to fetch details');
    }
  }

  @override
  Future<List<PlaceSuggestion>> fetchSuggestions({
    @required String input,
  }) async {
    final queryParameters = {
      'key': GOOGLE_API_KEY,
      'input': input,
      'location': '44.496993,11.357393',
      'radius': '2000',
      'language': 'it',
      'components': 'country:it',
    };
    final uri = Uri.https(
      AUTHORITY,
      AUTOCOMPLETE_UNENCODED_PATH,
      queryParameters,
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final predictionsJson = json.decode(response.body)['predictions'] as List;
      List<PlaceSuggestion> suggestions = predictionsJson
          .map((predictionJson) => PlaceSuggestion.fromJson(predictionJson))
          .toList();
      return suggestions;
    } else {
      throw Exception('Failed to fetch predictions');
    }
  }
}

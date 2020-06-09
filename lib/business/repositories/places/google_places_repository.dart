part of 'places_repository.dart';

/// Implementation of the [PlacesService] interface that uses
/// the package [google_maps_webservice] which is simply a wrapper
/// around Google Places APIs.
class GooglePlacesRepository implements PlacesRepository {
  static const GOOGLE_API_KEY = 'AIzaSyC5k8IchkmGBB4bNVjkIpVjm_X-XVMEvXQ';
  final places = GoogleMapsPlaces(apiKey: GOOGLE_API_KEY);
  final geocoding = GoogleMapsGeocoding(apiKey: GOOGLE_API_KEY);

  @override
  Future<Place> getPlaceFromCoords(double latitude, double longitude) async {
    final geocodingResponse = await geocoding.searchByLocation(
      Location(latitude, longitude),
    );
    final firstResult = geocodingResponse.results.first;
    return await _getDetailsByPlaceId(firstResult.placeId);
  }

  @override
  Future<Place> getPlaceFromSuggestion(PlaceSuggestion suggestion) async {
    return await _getDetailsByPlaceId(suggestion.placeId);
  }

  @override
  Future<List<PlaceSuggestion>> getSuggestions(
    String input,
    double latitude,
    double longitude,
  ) async {
    final response = await places.autocomplete(
      input,
      language: window.locale.languageCode,
      location: Location(latitude, longitude),
      radius: 50000,
      sessionToken: Uuid().v4(),
    );
    return response.predictions.map((p) {
      final formatting = p.structuredFormatting;
      return PlaceSuggestion(
        placeId: p.placeId,
        mainText: formatting.mainText,
        secondaryText: formatting.secondaryText,
      );
    }).toList();
  }

  Future<Place> _getDetailsByPlaceId(String placeId) async {
    final response = await places.getDetailsByPlaceId(
      placeId,
      fields: ['formatted_address', 'geometry', 'name', 'place_id'],
      language: window.locale.languageCode,
      sessionToken: Uuid().v4(),
    );
    final result = response.result;
    final resultCoords = result.geometry.location;
    return Place(
      placeId: result.placeId,
      formattedAddress: result.formattedAddress,
      coords: Coordinates(
        latitude: resultCoords.lat,
        longitude: resultCoords.lng,
      ),
      name: result.name,
    );
  }
}

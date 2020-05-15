part of 'places_repository.dart';

/// Implementation of the [PlacesService] interface that uses
/// the package [google_maps_webservice] which is simply a wrapper
/// around Google Places APIs.
class GooglePlacesRepository implements PlacesRepository {
  static const GOOGLE_API_KEY = 'AIzaSyC5k8IchkmGBB4bNVjkIpVjm_X-XVMEvXQ';
  final places = GoogleMapsPlaces(apiKey: GOOGLE_API_KEY);
  final geocoding = GoogleMapsGeocoding(apiKey: GOOGLE_API_KEY);

  @override
  Future<Place> getDetails(
    String placeId,
  ) async {
    final response = await places.getDetailsByPlaceId(
      placeId,
      fields: ['formatted_address', 'geometry', 'name', 'place_id'],
      language: 'it',
      sessionToken: Uuid().v4(),
    );
    final result = response.result;
    final resultCoords = response.result.geometry.location;
    return Place(
      placeId: result.placeId,
      formattedAddress: result.formattedAddress,
      latitude: resultCoords.lat,
      longitude: resultCoords.lng,
      name: result.name,
    );
  }

  @override
  Future<String> getPlaceId(
    double latitude,
    double longitude,
  ) async {
    final response = await geocoding.searchByLocation(
      Location(latitude, longitude),
    );
    final firstResult = response.results[0];
    return firstResult.placeId;
  }

  @override
  Future<List<PlaceSuggestion>> getSuggestions(
    String input,
    double latitude,
    double longitude,
  ) async {
    final response = await places.autocomplete(
      input,
      components: [Component(Component.country, 'it')],
      language: 'it',
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
}

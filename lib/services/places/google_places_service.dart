part of 'places_service.dart';

/// Implementation of the [PlacesService] interface that uses
/// the package [google_maps_webservice] which is simply a wrapper
/// around Google Places APIs.
class GooglePlacesService implements PlacesService {
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
      coordinates: Coordinates(resultCoords.lat, resultCoords.lng),
      name: result.name,
    );
  }

  @override
  Future<String> getPlaceId(
    Coordinates coordinates,
  ) async {
    final response = await geocoding.searchByLocation(
      Location(coordinates.latitude, coordinates.longitude),
    );
    final firstResult = response.results[0];
    return firstResult.placeId;
  }

  @override
  Future<List<PlaceSuggestion>> getSuggestions(
    String input,
    Coordinates coordinates,
  ) async {
    final response = await places.autocomplete(
      input,
      components: [Component(Component.country, 'it')],
      language: 'it',
      location: Location(coordinates.latitude, coordinates.longitude),
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

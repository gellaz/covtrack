part of 'places_service.dart';

class GooglePlacesService implements PlacesService {
  static const GOOGLE_API_KEY = 'AIzaSyC5k8IchkmGBB4bNVjkIpVjm_X-XVMEvXQ';
  final places = GoogleMapsPlaces(apiKey: GOOGLE_API_KEY);

  @override
  Future<Place> fetchPlaceDetails(String placeId) async {}

  @override
  Future<List<PlaceSuggestion>> fetchPlaceSuggestions(String input) async {
    final response = await places.autocomplete(input);
  }
}

import 'dart:ui';

import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../data/coordinates.dart';
import '../../../data/place.dart';
import '../../../data/place_suggestion.dart';
import 'places_repository.dart';

/// Implementation of the [PlacesService] interface that uses
/// the package [google_maps_webservice] which is simply a wrapper
/// around Google Maps APIs.
class GooglePlacesRepository implements PlacesRepository {
  /// API key necessary to access Google Maps webservices.
  final String googleApiKey;

  /// Wrapper for the Google Places API.
  final GoogleMapsPlaces places;

  /// Wrapper for the Google Geocoding API.
  final GoogleMapsGeocoding geocoding;

  GooglePlacesRepository({@required this.googleApiKey})
      : assert(googleApiKey != null),
        places = GoogleMapsPlaces(apiKey: googleApiKey),
        geocoding = GoogleMapsGeocoding(apiKey: googleApiKey);

  @override
  Future<Place> getPlaceFromCoords({
    @required double latitude,
    @required double longitude,
  }) async {
    final geocodingResponse = await geocoding.searchByLocation(
      Location(latitude, longitude),
    );
    final firstResult = geocodingResponse.results.first;
    return await _getDetailsByPlaceId(firstResult.placeId);
  }

  @override
  Future<Place> getPlaceFromSuggestion({
    @required PlaceSuggestion suggestion,
  }) async {
    return await _getDetailsByPlaceId(suggestion.placeId);
  }

  @override
  Future<List<PlaceSuggestion>> getSuggestions({
    @required String input,
    @required double latitude,
    @required double longitude,
  }) async {
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

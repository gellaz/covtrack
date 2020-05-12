import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:uuid/uuid.dart';

import '../../models/coordinates.dart';
import '../../models/place.dart';
import '../../models/place_suggestion.dart';

part 'google_places_service.dart';

/// Contract that all the implementations of the interface must follow.
abstract class PlacesService {
  /// Returns a list of suggested places matching the [input] string entered by
  /// the user and computed starting from the given [coordinates].
  Future<List<PlaceSuggestion>> getSuggestions(
    String input,
    Coordinates coordinates,
  );

  /// Returns the id for the place with the given [coordinates].
  Future<String> getPlaceId(
    Coordinates coordinates,
  );

  /// Returns the details for the given [placeId]. In particular returns a [Place]
  /// object with all the useful information: placeId, coordinates, formattedAddress,
  /// name.
  Future<Place> getDetails(
    String placeId,
  );
}

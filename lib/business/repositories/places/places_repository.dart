import '../../../data/place.dart';
import '../../../data/place_suggestion.dart';
import 'package:meta/meta.dart';

/// Contract that all the implementations of the [PlacesRepository] interface must follow.
/// This interface is an abstraction to let the user retrieve different kind of information
/// about the places in the nearby area. In particular:
///
/// 1. Retrieve a list of [PlaceSuggestion] given an input query and a location in terms of latitude and longitude.
/// 2. Retrieve a [Place] given the latitude and the longitude of that place.
/// 3. Retrieve the name of a place given the
abstract class PlacesRepository {
  /// Returns the the place with the given coordinates ([latitude] and
  /// [longitude]).
  Future<Place> getPlaceFromCoords({
    @required double latitude,
    @required double longitude,
  });

  /// Returns the [Place] associated to the given [suggestion].
  Future<Place> getPlaceFromSuggestion({
    @required PlaceSuggestion suggestion,
  });

  /// Returns a list of suggested places matching the [input] string entered by
  /// the user and computed starting from the given coordinates ([latitude] and
  /// [longitude]).
  Future<List<PlaceSuggestion>> getSuggestions({
    @required String input,
    @required double latitude,
    @required double longitude,
  });
}

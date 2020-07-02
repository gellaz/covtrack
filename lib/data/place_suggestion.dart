import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Class representing a suggestion of a place. In particular, this model is
/// used to represent the suggestions that the user receives while typing the
/// wanted a destination using a search bar.
class PlaceSuggestion extends Equatable {
  /// Unique ID of the place.
  final String placeId;

  /// Main string describing the place.
  final String mainText;

  /// Secondary string describing the place.
  final String secondaryText;

  const PlaceSuggestion({
    @required this.placeId,
    @required this.mainText,
    @required this.secondaryText,
  });

  @override
  List<Object> get props => [
        placeId,
        mainText,
        secondaryText,
      ];

  @override
  String toString() {
    return '''
    PlaceSuggestion {
      placeId: $placeId,
      mainText: $mainText,
      secondaryText: $secondaryText,
    }''';
  }
}

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PlaceSuggestion extends Equatable {
  @required
  final String placeId;
  @required
  final String mainText;
  @required
  final String secondaryText;

  const PlaceSuggestion({
    this.placeId,
    this.mainText,
    this.secondaryText,
  });

  @override
  List<Object> get props => [
        placeId,
        mainText,
        secondaryText,
      ];

  @override
  String toString() {
    return '''PlaceSuggestion {
      placeId: $placeId,
      mainText: $mainText,
      secondaryText: $secondaryText,
    }''';
  }
}

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PlaceSuggestion extends Equatable {
  final String placeId;
  final String mainText;
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
    return '''PlaceSuggestion {
      placeId: $placeId,
      mainText: $mainText,
      secondaryText: $secondaryText,
    }''';
  }
}

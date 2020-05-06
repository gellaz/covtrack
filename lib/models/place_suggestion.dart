import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PlaceSuggestion extends Equatable {
  final String placeId;
  final String description;
  final String mainText;
  final String secondaryText;

  const PlaceSuggestion({
    @required this.placeId,
    @required this.description,
    @required this.mainText,
    @required this.secondaryText,
  });

  factory PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    return PlaceSuggestion(
      placeId: json['place_id'],
      description: json['description'],
      mainText: json['structured_formatting']['main_text'],
      secondaryText: json['structured_formatting']['secondary_text'],
    );
  }

  @override
  List<Object> get props => [placeId, description, mainText, secondaryText];

  @override
  String toString() {
    return '''
    PlaceSuggestion {
      placeId: $placeId,
      description: $description,
      mainText: $mainText,
      secondaryText: $secondaryText,
    }''';
  }
}

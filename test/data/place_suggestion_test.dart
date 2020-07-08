import 'package:covtrack/data/place_suggestion.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlaceSuggestion', () {
    final PlaceSuggestion placeSuggestion1 = PlaceSuggestion(
      placeId: 'ABCD1234',
      mainText: 'Viale Rossi, 4',
      secondaryText: 'Bologna BO, Italy',
    );
    final PlaceSuggestion placeSuggestion2 = PlaceSuggestion(
      placeId: 'WXYZ5678',
      mainText: 'Best Supermarket',
      secondaryText: 'Via Verdi, 2, 40120 Bologna BO, Italy',
    );
    final PlaceSuggestion placeSuggestion3 = PlaceSuggestion(
      placeId: 'ABCD1234',
      mainText: 'Viale Rossi, 4',
      secondaryText: 'Bologna BO, Italy',
    );

    test('equality comparison uses the object properties and not references',
        () {
      expect(placeSuggestion1, isNot(placeSuggestion2));
      expect(placeSuggestion1, equals(placeSuggestion3));
    });
  });
}

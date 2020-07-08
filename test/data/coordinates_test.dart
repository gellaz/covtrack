import 'package:covtrack/data/coordinates.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Coordinates', () {
    final Coordinates coords1 = Coordinates(
      latitude: 12.34,
      longitude: 56.78,
    );
    final Coordinates coords2 = Coordinates(
      latitude: 21.43,
      longitude: 65.87,
    );
    final Coordinates coords3 = Coordinates(
      latitude: 12.34,
      longitude: 56.78,
    );

    test('latLngStr getter returns a string in the format "latitude,longitude"',
        () {
      expect(coords1.latLngStr, '12.34,56.78');
    });

    test('correctly deserialized from JSON', () {
      expect(
        Coordinates.fromJson({"latitude": 12.34, "longitude": 56.78}),
        coords1,
      );
    });

    test('equality comparison uses the object properties and not references',
        () {
      expect(coords1, isNot(coords2));
      expect(coords1, equals(coords3));
    });
  });
}

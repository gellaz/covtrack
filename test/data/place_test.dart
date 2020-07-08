import 'package:covtrack/data/coordinates.dart';
import 'package:covtrack/data/place.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Place', () {
    final Place place1 = Place(
      placeId: 'ABCD1234',
      coords: Coordinates(latitude: 12.34, longitude: 56.78),
      formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
      name: 'Viale Rossi, 4',
    );
    final Place place2 = Place(
      placeId: 'WXYZ5678',
      coords: Coordinates(latitude: 21.43, longitude: 65.87),
      formattedAddress: 'Via Verdi, 2, 40120 Bologna BO, Italy',
      name: 'Best Supermarket',
    );
    final Place place3 = Place(
      placeId: 'ABCD1234',
      coords: Coordinates(latitude: 12.34, longitude: 56.78),
      formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
      name: 'Viale Rossi, 4',
    );

    test('mainText getter returns the name property of the object', () {
      expect(place1.mainText, 'Viale Rossi, 4');
    });

    test(
        'secondaryText getter returns the formattedAddress property if the name property is contained in the formattedAddress otherwise returns the second part of the formattedAddress string after the comma',
        () {
      expect(place1.secondaryText, '40126 Bologna BO, Italy');
      expect(place2.secondaryText, 'Via Verdi, 2, 40120 Bologna BO, Italy');
    });

    test('coordsStr getter returns a string in the format "latitude,longitude"',
        () {
      expect(place1.coordsStr, '12.34,56.78');
    });

    test('correctly serialized to JSON', () {
      expect(
        place1.toJson(),
        {
          "placeId": "ABCD1234",
          "coords": {
            "latitude": 12.34,
            "longitude": 56.78,
          },
          "formattedAddress": "Viale Rossi, 4, 40126 Bologna BO, Italy",
          "name": "Viale Rossi, 4",
        },
      );
    });

    test('correctly deserialized from JSON', () {
      expect(
        Place.fromJson({
          "placeId": "ABCD1234",
          "coords": {
            "latitude": 12.34,
            "longitude": 56.78,
          },
          "formattedAddress": "Viale Rossi, 4, 40126 Bologna BO, Italy",
          "name": "Viale Rossi, 4",
        }),
        place1,
      );
    });

    test(
        'copyWith method generates a copy of the object with only the specified properties updated',
        () {
      final Place place1updated = Place(
        placeId: 'ABCD1234',
        coords: Coordinates(latitude: 66.88, longitude: 99.06),
        formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
        name: 'Viale Rossi, 4',
      );

      expect(
        place1.copyWith(coords: Coordinates(latitude: 66.88, longitude: 99.06)),
        place1updated,
      );
      expect(place1, isNot(place1updated));
    });

    test('equality comparison uses the object properties and not references',
        () {
      expect(place1, isNot(place2));
      expect(place1, equals(place3));
    });
  });
}

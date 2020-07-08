import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covtrack/data/coordinates.dart';
import 'package:covtrack/data/old_destination.dart';
import 'package:covtrack/data/place.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FakeDocumentSnapshot extends Fake implements DocumentSnapshot {
  final Map<String, dynamic> data;

  FakeDocumentSnapshot(this.data);
}

void main() {
  group('OldDestination', () {
    final DocumentSnapshot documentSnapshot = FakeDocumentSnapshot(
      {
        "place": {
          "placeId": "ABCD1234",
          "coords": {
            "latitude": 12.34,
            "longitude": 56.78,
          },
          "formattedAddress": "Viale Rossi, 4, 40126 Bologna BO, Italy",
          "name": "Viale Rossi, 4",
        },
        "numVisits": 33,
      },
    );
    final OldDestination oldDestination1 = OldDestination(
      place: Place(
        placeId: 'ABCD1234',
        coords: Coordinates(latitude: 12.34, longitude: 56.78),
        formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
        name: 'Viale Rossi, 4',
      ),
      numVisits: 33,
    );
    final OldDestination oldDestination2 = OldDestination(
      place: Place(
        placeId: 'WXYZ5678',
        coords: Coordinates(latitude: 21.43, longitude: 65.87),
        formattedAddress: 'Via Verdi, 2, 40120 Bologna BO, Italy',
        name: 'Best Supermarket',
      ),
      numVisits: 15,
    );
    final OldDestination oldDestination3 = OldDestination(
      place: Place(
        placeId: 'ABCD1234',
        coords: Coordinates(latitude: 12.34, longitude: 56.78),
        formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
        name: 'Viale Rossi, 4',
      ),
      numVisits: 33,
    );

    test('coordsStr getter returns a string in the format "latitude,longitude"',
        () {
      expect(oldDestination1.coordsStr, '12.34,56.78');
    });

    test('correctly serialized to JSON', () {
      expect(
        oldDestination1.toJson(),
        {
          "place": {
            "placeId": "ABCD1234",
            "coords": {
              "latitude": 12.34,
              "longitude": 56.78,
            },
            "formattedAddress": "Viale Rossi, 4, 40126 Bologna BO, Italy",
            "name": "Viale Rossi, 4",
          },
          "numVisits": 33,
        },
      );
    });

    test('correctly deserialized from JSON', () {
      expect(
        OldDestination.fromJson({
          "place": {
            "placeId": "ABCD1234",
            "coords": {
              "latitude": 12.34,
              "longitude": 56.78,
            },
            "formattedAddress": "Viale Rossi, 4, 40126 Bologna BO, Italy",
            "name": "Viale Rossi, 4",
          },
          "numVisits": 33,
        }),
        oldDestination1,
      );
    });

    test('correctly generated from DocumentSnapshot', () {
      expect(OldDestination.fromSnapshot(documentSnapshot), oldDestination1);
    });

    test(
        'copyWith method generates a copy of the object with only the specified properties updated',
        () {
      final OldDestination oldDestination1updated = OldDestination(
        place: Place(
          placeId: 'ABCD1234',
          coords: Coordinates(latitude: 12.34, longitude: 56.78),
          formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
          name: 'Viale Rossi, 4',
        ),
        numVisits: 500,
      );
      expect(oldDestination1.copyWith(numVisits: 500), oldDestination1updated);
      expect(oldDestination1, isNot(oldDestination1updated));
    });

    test('equality comparison uses the object properties and not references',
        () {
      expect(oldDestination1, isNot(oldDestination2));
      expect(oldDestination1, equals(oldDestination3));
    });
  });
}

import 'package:covtrack/data/coordinates.dart';
import 'package:covtrack/data/place.dart';
import 'package:covtrack/data/stop.dart';
import 'package:covtrack/data/trip.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FakeDocumentSnapshot extends Fake implements DocumentSnapshot {
  final Map<String, dynamic> data;

  FakeDocumentSnapshot(this.data);

  @override
  String get documentID => 'ABCD_1234';
}

void main() {
  group('Trip', () {
    final DocumentSnapshot documentSnapshot = FakeDocumentSnapshot(
      {
        "tripId": "ABCD_1234",
        "reason": "Proven work needs",
        "startingTime": "2020-01-15T10:30:20.099137",
        "arrivalTime": "2020-01-15T12:05:20.099224",
        "source": {
          "placeId": "ABCD1234",
          "coords": {
            "latitude": 12.34,
            "longitude": 56.78,
          },
          "formattedAddress": "Viale Rossi, 4, 40126 Bologna BO, Italy",
          "name": "Viale Rossi, 4",
        },
        "destination": {
          "placeId": "WXYZ5678",
          "coords": {
            "latitude": 21.43,
            "longitude": 65.87,
          },
          "formattedAddress": "Via Verdi, 2, 40120 Bologna BO, Italy",
          "name": "Best Supermarket",
        },
        "stops": [
          {
            "coords": {
              "latitude": 12.34,
              "longitude": 56.78,
            },
            "time": "2020-01-15T10:30:20.099137",
          },
          {
            "coords": {
              "latitude": 21.43,
              "longitude": 65.87,
            },
            "time": "2020-01-15T12:05:20.099224",
          },
        ],
      },
    );
    final Trip trip1 = Trip(
      tripId: 'ABCD_1234',
      reason: 'Proven work needs',
      startingTime: DateTime(2020, 1, 15, 10, 30, 20, 99, 137),
      arrivalTime: DateTime(2020, 1, 15, 12, 5, 20, 99, 224),
      source: Place(
        placeId: 'ABCD1234',
        coords: Coordinates(latitude: 12.34, longitude: 56.78),
        formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
        name: 'Viale Rossi, 4',
      ),
      destination: Place(
        placeId: 'WXYZ5678',
        coords: Coordinates(latitude: 21.43, longitude: 65.87),
        formattedAddress: 'Via Verdi, 2, 40120 Bologna BO, Italy',
        name: 'Best Supermarket',
      ),
      stops: <Stop>[
        Stop(
          coords: Coordinates(
            latitude: 12.34,
            longitude: 56.78,
          ),
          time: DateTime(2020, 1, 15, 10, 30, 20, 99, 137),
        ),
        Stop(
          coords: Coordinates(
            latitude: 21.43,
            longitude: 65.87,
          ),
          time: DateTime(2020, 1, 15, 12, 5, 20, 99, 224),
        ),
      ],
    );
    final Trip trip2 = Trip(
      tripId: 'WXYZ_5678',
      reason: 'Health needs',
      startingTime: DateTime(2020, 1, 16, 10, 30, 20, 99, 137),
      arrivalTime: DateTime(2020, 1, 16, 12, 5, 20, 99, 224),
      source: Place(
        placeId: 'ABCD1234',
        coords: Coordinates(latitude: 12.34, longitude: 56.78),
        formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
        name: 'Viale Rossi, 4',
      ),
      destination: Place(
        placeId: 'WXYZ5678',
        coords: Coordinates(latitude: 21.43, longitude: 65.87),
        formattedAddress: 'Via Verdi, 2, 40120 Bologna BO, Italy',
        name: 'Best Supermarket',
      ),
      stops: <Stop>[
        Stop(
          coords: Coordinates(
            latitude: 12.34,
            longitude: 56.78,
          ),
          time: DateTime(2020, 1, 15, 10, 30, 20, 99, 137),
        ),
        Stop(
          coords: Coordinates(
            latitude: 21.43,
            longitude: 65.87,
          ),
          time: DateTime(2020, 1, 15, 12, 5, 20, 99, 224),
        ),
      ],
    );
    final Trip trip3 = Trip(
      tripId: 'ABCD_1234',
      reason: 'Proven work needs',
      startingTime: DateTime(2020, 1, 15, 10, 30, 20, 99, 137),
      arrivalTime: DateTime(2020, 1, 15, 12, 5, 20, 99, 224),
      source: Place(
        placeId: 'ABCD1234',
        coords: Coordinates(latitude: 12.34, longitude: 56.78),
        formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
        name: 'Viale Rossi, 4',
      ),
      destination: Place(
        placeId: 'WXYZ5678',
        coords: Coordinates(latitude: 21.43, longitude: 65.87),
        formattedAddress: 'Via Verdi, 2, 40120 Bologna BO, Italy',
        name: 'Best Supermarket',
      ),
      stops: <Stop>[
        Stop(
          coords: Coordinates(
            latitude: 12.34,
            longitude: 56.78,
          ),
          time: DateTime(2020, 1, 15, 10, 30, 20, 99, 137),
        ),
        Stop(
          coords: Coordinates(
            latitude: 21.43,
            longitude: 65.87,
          ),
          time: DateTime(2020, 1, 15, 12, 5, 20, 99, 224),
        ),
      ],
    );

    test('correctly serialized to JSON', () {
      expect(
        trip1.toJson(),
        {
          "tripId": "ABCD_1234",
          "reason": "Proven work needs",
          "startingTime": "2020-01-15T10:30:20.099137",
          "arrivalTime": "2020-01-15T12:05:20.099224",
          "source": {
            "placeId": "ABCD1234",
            "coords": {
              "latitude": 12.34,
              "longitude": 56.78,
            },
            "formattedAddress": "Viale Rossi, 4, 40126 Bologna BO, Italy",
            "name": "Viale Rossi, 4",
          },
          "destination": {
            "placeId": "WXYZ5678",
            "coords": {
              "latitude": 21.43,
              "longitude": 65.87,
            },
            "formattedAddress": "Via Verdi, 2, 40120 Bologna BO, Italy",
            "name": "Best Supermarket",
          },
          "stops": [
            {
              "coords": {
                "latitude": 12.34,
                "longitude": 56.78,
              },
              "time": "2020-01-15T10:30:20.099137",
            },
            {
              "coords": {
                "latitude": 21.43,
                "longitude": 65.87,
              },
              "time": "2020-01-15T12:05:20.099224",
            },
          ],
        },
      );
    });

    test('correctly deserialized from JSON', () {
      expect(
        Trip.fromJson({
          "tripId": "ABCD_1234",
          "reason": "Proven work needs",
          "startingTime": "2020-01-15T10:30:20.099137",
          "arrivalTime": "2020-01-15T12:05:20.099224",
          "source": {
            "placeId": "ABCD1234",
            "coords": {
              "latitude": 12.34,
              "longitude": 56.78,
            },
            "formattedAddress": "Viale Rossi, 4, 40126 Bologna BO, Italy",
            "name": "Viale Rossi, 4",
          },
          "destination": {
            "placeId": "WXYZ5678",
            "coords": {
              "latitude": 21.43,
              "longitude": 65.87,
            },
            "formattedAddress": "Via Verdi, 2, 40120 Bologna BO, Italy",
            "name": "Best Supermarket",
          },
          "stops": [
            {
              "coords": {
                "latitude": 12.34,
                "longitude": 56.78,
              },
              "time": "2020-01-15T10:30:20.099137",
            },
            {
              "coords": {
                "latitude": 21.43,
                "longitude": 65.87,
              },
              "time": "2020-01-15T12:05:20.099224",
            },
          ],
        }),
        trip1,
      );
    });

    test('correctly generated from DocumentSnapshot', () {
      expect(Trip.fromSnapshot(documentSnapshot), trip1);
    });

    test(
        'copyWith method generates a copy of the object with only the specified properties updated',
        () {
      final Trip trip1updated = Trip(
        tripId: 'ABCD_1234',
        reason: 'Necessity reasons',
        startingTime: DateTime(2020, 1, 15, 10, 30, 20, 99, 137),
        arrivalTime: DateTime(2020, 1, 15, 12, 5, 20, 99, 224),
        source: Place(
          placeId: 'ABCD1234',
          coords: Coordinates(latitude: 12.34, longitude: 56.78),
          formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
          name: 'Viale Rossi, 4',
        ),
        destination: Place(
          placeId: 'WXYZ5678',
          coords: Coordinates(latitude: 21.43, longitude: 65.87),
          formattedAddress: 'Via Verdi, 2, 40120 Bologna BO, Italy',
          name: 'Best Supermarket',
        ),
        stops: <Stop>[
          Stop(
            coords: Coordinates(
              latitude: 12.34,
              longitude: 56.78,
            ),
            time: DateTime(2020, 1, 15, 10, 30, 20, 99, 137),
          ),
          Stop(
            coords: Coordinates(
              latitude: 21.43,
              longitude: 65.87,
            ),
            time: DateTime(2020, 1, 15, 12, 5, 20, 99, 224),
          ),
        ],
      );
      expect(trip1.copyWith(reason: 'Necessity reasons'), trip1updated);
      expect(trip1, isNot(trip1updated));
    });

    test(
        'returnTrip method generates a trip with the source and destination swapped',
        () {
      expect(
        trip1.returnTrip(),
        Trip(
          tripId: null,
          reason: 'Proven work needs',
          startingTime: DateTime.now(),
          arrivalTime: null,
          source: Place(
            placeId: 'WXYZ5678',
            coords: Coordinates(latitude: 21.43, longitude: 65.87),
            formattedAddress: 'Via Verdi, 2, 40120 Bologna BO, Italy',
            name: 'Best Supermarket',
          ),
          destination: Place(
            placeId: 'ABCD1234',
            coords: Coordinates(latitude: 12.34, longitude: 56.78),
            formattedAddress: 'Viale Rossi, 4, 40126 Bologna BO, Italy',
            name: 'Viale Rossi, 4',
          ),
          stops: [],
        ),
      );
    });

    test('equality comparison uses the object properties and not references',
        () {
      expect(trip1, isNot(trip2));
      expect(trip1, equals(trip3));
    });
  });
}

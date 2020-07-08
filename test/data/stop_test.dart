import 'package:covtrack/data/coordinates.dart';
import 'package:covtrack/data/stop.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Stop', () {
    final Stop stop1 = Stop(
      coords: Coordinates(
        latitude: 12.34,
        longitude: 56.78,
      ),
      time: DateTime(2020, 1, 15, 10, 30, 20, 99, 137),
    );
    final Stop stop2 = Stop(
      coords: Coordinates(
        latitude: 21.43,
        longitude: 65.87,
      ),
      time: DateTime(2020, 1, 15, 12, 5, 20, 99, 224),
    );
    final Stop stop3 = Stop(
      coords: Coordinates(
        latitude: 12.34,
        longitude: 56.78,
      ),
      time: DateTime(2020, 1, 15, 10, 30, 20, 99, 137),
    );

    test('correctly serialized to JSON', () {
      expect(
        stop1.toJson(),
        {
          "coords": {
            "latitude": 12.34,
            "longitude": 56.78,
          },
          "time": "2020-01-15T10:30:20.099137",
        },
      );
    });

    test('correctly deserialized from JSON', () {
      expect(
        Stop.fromJson(
          {
            "coords": {
              "latitude": 12.34,
              "longitude": 56.78,
            },
            "time": "2020-01-15T10:30:20.099137",
          },
        ),
        stop1,
      );
    });

    test('equality comparison uses the object properties and not references',
        () {
      expect(stop1, isNot(stop2));
      expect(stop1, equals(stop3));
    });
  });
}

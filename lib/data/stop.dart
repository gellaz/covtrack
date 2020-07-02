import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'coordinates.dart';

/// Class representing a user's stop (when the user is stationary, not moving) during a trip.
class Stop extends Equatable {
  /// Geographical coordinates of the place.
  final Coordinates coords;

  /// Exact moment when the user stopped.
  final DateTime time;

  const Stop({
    @required this.coords,
    @required this.time,
  });

  /// Serializes the [Stop] object into a JSON format object.
  Map<String, Object> toJson() {
    return {
      "coords": coords.toJson(),
      "time": time.toIso8601String(),
    };
  }

  /// Deserializes the input [json] object into an [Stop] object.
  factory Stop.fromJson(Map<String, Object> json) {
    return Stop(
      coords: Coordinates.fromJson(json['coords']),
      time: DateTime.parse(json['time'] as String),
    );
  }

  @override
  List<Object> get props => [coords, time];

  @override
  String toString() {
    return '''
    Stop {
      location: $coords,
      time: $time,
    }''';
  }
}

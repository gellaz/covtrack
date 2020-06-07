import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'coordinates.dart';

class Stop extends Equatable {
  final Coordinates coords;
  final DateTime time;

  const Stop({
    @required this.coords,
    @required this.time,
  });

  Map<String, Object> toJson() {
    return {
      "coords": coords.toJson(),
      "time": time.toIso8601String(),
    };
  }

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

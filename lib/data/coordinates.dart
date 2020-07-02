import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Class representing the coordinates of a geographical point (latitude and longitude).
class Coordinates extends Equatable {
  /// Latitude of the point.
  final double latitude;

  /// Longitude of the point.
  final double longitude;

  const Coordinates({
    @required this.latitude,
    @required this.longitude,
  });

  /// Getter returning a string with the coordinates of the point
  /// in the following format: '[latitude],[longitude]'.
  String get latLngStr => '$latitude,$longitude';

  /// Serializes the [Coordinates] object into a JSON format object.
  Map<String, Object> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  /// Deserializes the input [json] object into a [Coordiates] object.
  factory Coordinates.fromJson(Map<String, Object> json) {
    return Coordinates(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

  @override
  List<Object> get props => [latitude, longitude];

  @override
  String toString() {
    return 'Coordinates { latitude: $latitude, longitude: $longitude }';
  }
}

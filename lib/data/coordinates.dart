import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Coordinates extends Equatable {
  final double latitude;
  final double longitude;

  const Coordinates({
    @required this.latitude,
    @required this.longitude,
  });

  Map<String, Object> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
    };
  }

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

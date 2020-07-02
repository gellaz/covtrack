import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'coordinates.dart';

/// Class representing a place. A place is characterized by geographical
/// coordinates, an address and a name (if the place is a business).
class Place extends Equatable {
  /// Unique ID of the place.
  final String placeId;

  /// Geographical coordinates of the place.
  final Coordinates coords;

  /// Address of the place.
  final String formattedAddress;

  /// Name of the place.
  final String name;

  const Place({
    @required this.placeId,
    @required this.coords,
    @required this.formattedAddress,
    @required this.name,
  });

  /// Getter returning the main string describing the place.
  String get mainText => name;

  /// Getter returning a secondary string describing the place.
  String get secondaryText => formattedAddress.contains(name)
      ? formattedAddress.replaceFirst(RegExp(name + ','), '').trim()
      : formattedAddress;

  /// Getter returning a string with the coordinates of the point
  /// in the following format: '[latitude],[longitude]'.
  String get coordsStr => '${coords.latLngStr}';

  /// Serializes the [Place] object into a JSON format object.
  Map<String, Object> toJson() {
    return {
      "placeId": placeId,
      "coords": coords.toJson(),
      "formattedAddress": formattedAddress,
      "name": name,
    };
  }

  /// Deserializes the input [json] object into an [Place] object.
  factory Place.fromJson(Map<String, Object> json) {
    return Place(
      placeId: json['placeId'] as String,
      coords: Coordinates.fromJson(json['coords']),
      formattedAddress: json['formattedAddress'] as String,
      name: json['name'] as String,
    );
  }

  /// Returns a copy of the [Place] object where only the properties
  /// passed in as arguments are updated.
  Place copyWith({
    String placeId,
    Coordinates coords,
    String formattedAddress,
    String name,
  }) {
    return Place(
      placeId: placeId ?? this.placeId,
      coords: coords ?? this.coords,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [
        placeId,
        coords,
        formattedAddress,
        name,
      ];

  @override
  String toString() {
    return '''
    Place {
      placeId: $placeId,
      coords: $coords,
      formattedAddress: $formattedAddress,
      name: $name,
    }''';
  }
}

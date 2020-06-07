import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'coordinates.dart';

class Place extends Equatable {
  final String placeId;
  final Coordinates coords;
  final String formattedAddress;
  final String name;

  const Place({
    @required this.placeId,
    @required this.coords,
    @required this.formattedAddress,
    @required this.name,
  });

  String get mainText => name;

  String get secondaryText => formattedAddress.contains(name)
      ? formattedAddress.replaceFirst(RegExp(name + ','), '').trim()
      : formattedAddress;

  Map<String, Object> toJson() {
    return {
      "placeId": placeId,
      "coords": coords.toJson(),
      "formattedAddress": formattedAddress,
      "name": name,
    };
  }

  factory Place.fromJson(Map<String, Object> json) {
    return Place(
      placeId: json['placeId'] as String,
      coords: Coordinates.fromJson(json['coords']),
      formattedAddress: json['formattedAddress'] as String,
      name: json['name'] as String,
    );
  }

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

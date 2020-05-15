import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Place extends Equatable {
  final String placeId;
  final double latitude;
  final double longitude;
  final String formattedAddress;
  final String name;

  const Place({
    @required this.placeId,
    @required this.latitude,
    @required this.longitude,
    @required this.formattedAddress,
    @required this.name,
  });

  String get mainText => name;

  String get secondaryText => formattedAddress.contains(name)
      ? formattedAddress.replaceFirst(RegExp(name + ','), '').trim()
      : formattedAddress;

  Map<String, dynamic> toMap() {
    return {
      'placeId': placeId,
      'latitude': latitude,
      'longitude': longitude,
      'formattedAddress': formattedAddress,
      'name': name,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      placeId: map['placeId'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      formattedAddress: map['formattedAddress'],
      name: map['name'],
    );
  }

  Place copyWith({
    String placeId,
    double latitude,
    double longitude,
    String formattedAddress,
    String name,
  }) {
    return Place(
      placeId: placeId ?? this.placeId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [
        placeId,
        latitude,
        longitude,
        formattedAddress,
        name,
      ];

  @override
  String toString() {
    return '''
    Place {
      placeId: $placeId,
      latitude: $latitude,
      longitude: $longitude,
      formattedAddress: $formattedAddress,
      name: $name,
    }''';
  }
}

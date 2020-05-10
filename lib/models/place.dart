import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String id;
  final double latitude;
  final double longitude;
  final String name;
  final String formattedAddress;

  const Place({
    this.id,
    this.latitude,
    this.longitude,
    this.name,
    this.formattedAddress,
  });

  Place copyWith({
    String id,
    double latitude,
    double longitude,
    String name,
    String formattedAddress,
  }) {
    return Place(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      formattedAddress: formattedAddress ?? this.formattedAddress,
    );
  }

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['place_id'],
      latitude: json['geometry']['location']['lat'],
      longitude: json['geometry']['location']['lng'],
      name: json['name'],
      formattedAddress: json['formatted_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'formattedAddress': formattedAddress,
    };
  }

  @override
  List<Object> get props => [
        id,
        latitude,
        longitude,
        name,
        formattedAddress,
      ];

  @override
  String toString() {
    return '''
    Place {
      id: $id,
      latitude: $latitude,
      longitude: $longitude,
      name: $name,
      formattedAddress: $formattedAddress,
    }''';
  }
}

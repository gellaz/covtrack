import 'package:covtrack/models/coordinates.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Place extends Equatable {
  final String placeId;
  final Coordinates coordinates;
  final String formattedAddress;
  final String name;

  const Place({
    @required this.placeId,
    @required this.coordinates,
    @required this.formattedAddress,
    this.name,
  });

  String get mainText => name;

  String get secondaryText => formattedAddress.contains(name)
      ? formattedAddress.replaceFirst(RegExp(name + ','), '').trim()
      : formattedAddress;

  Place copyWith({
    String placeId,
    Coordinates coordinates,
    String formattedAddress,
    String name,
  }) {
    return Place(
      placeId: placeId ?? this.placeId,
      coordinates: coordinates ?? this.coordinates,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [
        placeId,
        coordinates,
        formattedAddress,
        name,
      ];

  @override
  String toString() {
    return '''
    Place {
      placeId: $placeId,
      coordinates: $coordinates,
      formattedAddress: $formattedAddress,
      name: $name,
    }''';
  }
}

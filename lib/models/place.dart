import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Place extends Equatable {
  final double latitude;
  final double longitude;
  final String address;

  Place({
    @required this.latitude,
    @required this.longitude,
    @required this.address,
  });

  @override
  List<Object> get props => [latitude, longitude, address];

  @override
  String toString() {
    return '''
    Place {
      latitude: $latitude,
      longitude: $longitude,
      address: $address,
    }''';
  }
}

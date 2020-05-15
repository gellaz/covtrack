import 'place.dart';
import 'package:meta/meta.dart';

class House extends Place {
  final bool current;

  const House({
    @required placeId,
    @required latitude,
    @required longitude,
    @required formattedAddress,
    @required name,
    @required this.current,
  }) : super(
          placeId: placeId,
          latitude: latitude,
          longitude: longitude,
          formattedAddress: formattedAddress,
          name: name,
        );

  @override
  String toString() {
    return '''
    House {
      placeId: $placeId,
      latitude: $latitude,
      longitude: $longitude,
      formattedAddress: $formattedAddress,
      name: $name,
      current: $current,
    }''';
  }
}

/// Contract that all the implementations of the interface must follow.
abstract class LocationRepository {
  /// Return the current location of the user in terms of coordinates
  /// (latitude and longitude).
  Future getCurrentLocation();
}

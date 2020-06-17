import '../../../data/trip.dart';

/// Contract that all implementations of [TripsRepository] interface must follow.
/// It provides all the necessary CRUD operations to manage a database of [Trip] objects.
/// Extended whenever we want to integrate with a different Trips provider.
abstract class TripsRepository {
  /// Deletes all the saved trips for the given user.
  Future<void> clear();

  /// Deletes the given [trip] from the list of user's trips.
  Future<void> delete({Trip trip});

  /// Inserts the given [trip] to the list of user's trips.
  Future<void> insert({Trip trip});

  /// Returns a stream of containing a list of [Trip] objects that we can listen to.
  Stream<List<Trip>> trips();

  /// Updates the given [trip].
  Future<void> update({Trip trip});
}

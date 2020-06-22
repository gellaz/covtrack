import 'package:meta/meta.dart';

import '../../../data/trip.dart';

/// Contract that all implementations of [TripsRepository] interface must follow.
/// It provides all the necessary methods to perform CRUD operations on a database
/// of [Trip] objects.
abstract class TripsRepository {
  /// Deletes all the trips saved in the database.
  Future<void> clear();

  /// Deletes the given [trip] from the list of user's trips.
  Future<void> delete({@required Trip trip});

  /// Inserts the given [trip] into the list of user's trips.
  Future<void> insert({@required Trip trip});

  /// Returns a stream of containing a list of [Trip] objects sorted in descending order
  /// according to starting time of the trip.
  Stream<List<Trip>> trips();

  /// Updates the given [trip] in the list of user's trips.
  Future<void> update({@required Trip trip});
}

import 'package:meta/meta.dart';

import '../../../data/trip.dart';

/// Contract that all implementations of [TripsRepository] interface must follow.
/// It provides all the necessary methods to perform CRUD operations on a database
/// of [Trip] objects.
abstract class TripsRepository {
  /// Deletes the given [trip] from the list of user's trips.
  Future<void> delete({@required Trip trip});

  /// Inserts the given [trip] into the list of user's trips.
  Future<void> insert({@required Trip trip});

  /// Returns a stream of containing a list of [Trip] objects that we can listen to.
  Stream<List<Trip>> trips();

  /// Updates the given [trip] in the list of user's trips.
  Future<void> update({@required Trip trip});
}

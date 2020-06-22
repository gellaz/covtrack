import 'package:covtrack/data/place.dart';

import '../../../data/old_destination.dart';

/// Contract that all implementations of [OldDestinationsRepository] interface must follow.
/// It provides all the necessary methods to perform CRUD operations on a database
/// of [OldDestination] objects.
abstract class OldDestinationsRepository {
  /// Deletes all the reached destinations saved in the database.
  Future<void> clear();

  /// Deletes the given [destination] from the list of user's old destinations if it doesn't exist yet
  /// otherwise updates the number of visits of the existing destination by increasing it by one.
  Future<void> deleteDestination({Place destination});

  /// Returns a stream of containing a list of [OldDestination] objects sorted in descending order
  /// according to the number of visits.
  Stream<List<OldDestination>> destinations();

  /// Increments the number of visits saved in the database for the given [destination]. If the
  /// destination does not exist yet, it creates it and initializes the number of visits counter to one.
  Future<void> incrementNumVisits({Place destination});
}

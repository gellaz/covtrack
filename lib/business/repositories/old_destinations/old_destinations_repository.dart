import 'package:covtrack/data/place.dart';

import '../../../data/old_destination.dart';

/// Contract that all implementations of [OldDestinationsRepository] interface must follow.
/// It provides all the necessary methods to perform CRUD operations on a database
/// of [OldDestination] objects.
abstract class OldDestinationsRepository {
  /// Deletes the given [destination] from the list of user's old destinations if it doesn't exist yet
  /// otherwise updates the number of visits of the existing destination by increasing it by one.
  Future<void> deleteDestination({Place destination});

  /// Inserts the given [destination] into the list of user's old destinations.
  Future<void> setDestination({Place destination});

  /// Returns a stream of containing a list of [OldDestination] objects that we can listen to.
  Stream<List<OldDestination>> destinations();
}

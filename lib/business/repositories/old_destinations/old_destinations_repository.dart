import '../../../data/old_destination.dart';
import '../../../data/place.dart';

/// Contract that all implementations of [OldDestinationsRepository] interface must follow.
/// It provides all the necessary methods to perform CRUD operations on a database
/// of [OldDestination] objects.
abstract class OldDestinationsRepository {
  /// Deletes the given [oldDestination] from the list of user's old destinations.
  Future<void> deleteDestination({OldDestination oldDestination});

  /// Returns a stream of containing a list of [OldDestination] objects that we can listen to.
  Stream<List<OldDestination>> destinations();

  /// Inserts the given [oldDestination] into the list of user's old destinations if not present yet,
  /// otherwise increments by one the number of visits of the existing old destination.
  Future<void> setDestination({Place destination});
}

import '../../../data/old_destination.dart';

/// Contract that all implementations of [OldDestinationsRepository] interface must follow.
/// It provides all the necessary methods to perform CRUD operations on a database
/// of [OldDestination] objects.
abstract class OldDestinationsRepository {
  /// Returns a stream of containing a list of [OldDestination] objects that we can listen to.
  Stream<List<OldDestination>> destinations();
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covtrack/data/place.dart';
import 'package:meta/meta.dart';

import '../../../data/old_destination.dart';
import 'old_destinations_repository.dart';

/// Implementation of the [OldDestinationsRepository] interface. It manages the integration with Firebase
/// remote NoSQL database service Cloud Firestore. The database is structured following Cloud Firestore's
/// data model: there is a root collection `users` which contains a document for every user identified by
/// user's [uid]. Each document contains a sub-collection `destinations` containing all the destinations
/// reached by the user during his previous trips, each one identified by a string with the following
/// structure: '<destination_latitude>,<destination_longitude>'.
class FirestoreOldDestinationsRepository implements OldDestinationsRepository {
  /// User id that identifies the corresponding user
  /// document inside the `users` collection.
  final String uid;

  /// Reference to the collection containing user's destinations.
  final CollectionReference userDestinations;

  FirestoreOldDestinationsRepository({@required this.uid})
      : assert(uid != null),
        userDestinations = Firestore.instance
            .collection('users')
            .document(uid)
            .collection('destinations');

  @override
  Future<void> deleteDestination({
    @required Place destination,
  }) async {
    return userDestinations.document(destination.coordsStr).delete();
  }

  @override
  Stream<List<OldDestination>> destinations() {
    return userDestinations.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => OldDestination.fromSnapshot(doc))
          .toList()
            ..sort((o1, o2) => o1.numVisits.compareTo(o2.numVisits));
    });
  }

  @override
  Future<void> setDestination({
    @required Place destination,
  }) async {
    return userDestinations.document(destination.coordsStr).setData({
      "place": destination.toJson(),
      "numVisits": FieldValue.increment(1),
    });
  }
}

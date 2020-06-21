import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../data/trip.dart';
import 'trips_repository.dart';

/// Implementation of the [TripsRepository] interface. It manages the integration with Firebase
/// remote NoSQL database service Cloud Firestore. The database is structured following Cloud
/// Firestore's data model: there is a root collection `users` which contains a document for
/// every user identified by user's [uid]. Each document contains a sub-collection `trips`
/// that contains the trips of the user, each one identified by a unique id automatically
/// assigned at the time of insertion by Cloud Firestore.
class FirestoreTripsRepository implements TripsRepository {
  /// User id that identifies the corresponding user
  /// document inside the `users` collection.
  final String uid;

  /// Reference to the collection containing user's trips.
  final CollectionReference userTrips;

  FirestoreTripsRepository({@required this.uid})
      : assert(uid != null),
        userTrips = Firestore.instance
            .collection('users')
            .document(uid)
            .collection('trips');

  @override
  Future<void> clear() async {
    QuerySnapshot snap = await userTrips.getDocuments();
    return snap.documents.forEach(
      (DocumentSnapshot ds) => ds.reference.delete(),
    );
  }

  @override
  Future<void> delete({@required Trip trip}) async {
    return userTrips.document(trip.tripId).delete();
  }

  @override
  Future<void> insert({@required Trip trip}) async {
    return userTrips.add(trip.toJson());
  }

  @override
  Stream<List<Trip>> trips() {
    return userTrips.snapshots().map((snapshot) {
      return snapshot.documents.map((doc) => Trip.fromSnapshot(doc)).toList()
        ..sort((t1, t2) => t1.startingTime.compareTo(t2.startingTime));
    });
  }

  @override
  Future<void> update({@required Trip trip}) async {
    return userTrips.document(trip.tripId).updateData(trip.toJson());
  }
}

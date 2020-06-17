import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../data/trip.dart';
import 'trips_repository.dart';

/// Implementation of the [TripsRepository] interface. It manages the integration with
/// the Firebase's remote database service Cloud Firestore.
class FirestoreTripsRepository implements TripsRepository {
  final CollectionReference userTripsCollection;
  final String uid;

  FirestoreTripsRepository({@required this.uid})
      : assert(uid != null),
        userTripsCollection = Firestore.instance.collection(uid);

  @override
  Future<void> clear() async {
    QuerySnapshot snap = await userTripsCollection.getDocuments();
    return snap.documents.forEach(
      (DocumentSnapshot ds) => ds.reference.delete(),
    );
  }

  @override
  Future<void> delete({@required Trip trip}) async {
    return userTripsCollection.document(trip.tripId).delete();
  }

  @override
  Future<void> insert({@required Trip trip}) async {
    return userTripsCollection.add(trip.toJson());
  }

  @override
  Stream<List<Trip>> trips() {
    return userTripsCollection.snapshots().map((snapshot) {
      return snapshot.documents.map((doc) => Trip.fromSnapshot(doc)).toList()
        ..sort((t1, t2) => t1.startingTime.compareTo(t2.startingTime));
    });
  }

  @override
  Future<void> update({@required Trip trip}) async {
    return userTripsCollection.document(trip.tripId).updateData(trip.toJson());
  }
}

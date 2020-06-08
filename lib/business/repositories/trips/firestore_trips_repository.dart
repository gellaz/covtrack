import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../data/trip.dart';
import 'trips_repository.dart';

class FirestoreTripsRepository implements TripsRepository {
  final CollectionReference userTripsCollection;
  final String uid;

  FirestoreTripsRepository({@required this.uid})
      : assert(uid != null),
        userTripsCollection = Firestore.instance.collection(uid);

  @override
  Future<void> delete(Trip trip) async {
    return userTripsCollection.document(trip.tripId).delete();
  }

  @override
  Stream<List<Trip>> getAllTrips() {
    return userTripsCollection.snapshots().map((snapshot) {
      return snapshot.documents.map((doc) => Trip.fromSnapshot(doc)).toList()
        ..sort((t1, t2) => t1.startingTime.compareTo(t2.startingTime));
    });
  }

  @override
  Future<void> insert(Trip trip) async {
    return userTripsCollection.add(trip.toJson());
  }

  @override
  Future<void> update(Trip trip) async {
    return userTripsCollection.document(trip.tripId).updateData(trip.toJson());
  }

  @override
  Future<void> clear() async {
    QuerySnapshot snap = await userTripsCollection.getDocuments();
    return snap.documents.forEach(
      (DocumentSnapshot ds) => ds.reference.delete(),
    );
  }
}

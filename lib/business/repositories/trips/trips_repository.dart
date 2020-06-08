import '../../../data/trip.dart';

abstract class TripsRepository {
  Future<void> insert(Trip trip);
  Future<void> update(Trip trip);
  Future<void> delete(Trip trip);
  Stream<List<Trip>> getAllTrips();
  Future<void> clear();
}

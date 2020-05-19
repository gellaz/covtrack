import '../../../data/models/trip.dart';

abstract class TripsRepository {
  Future<void> insert(Trip trip);
  Future<void> update(Trip trip);
  Future<void> delete(Trip trip);
  Future<List<Trip>> getAllTrips();
}

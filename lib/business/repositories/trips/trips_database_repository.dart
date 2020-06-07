import 'package:sembast/sembast.dart';

import '../../../data/trip.dart';
import '../../providers/app_database.dart';
import 'trips_repository.dart';

class TripsDatabaseRepository implements TripsRepository {
  // The name of the store.
  static const String TRIPS_STORE_NAME = 'trips';

  // This store acts like a persistent map, values of which are Trip objects
  // converted to Map.
  final _tripsStore = stringMapStoreFactory.store(TRIPS_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the singleton
  // instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  @override
  Future<void> insert(Trip trip) async {
    await _tripsStore.add(await _db, trip.toJson());
  }

  @override
  Future<void> update(Trip trip) async {
    final finder = Finder(filter: Filter.byKey(trip.tripId));
    await _tripsStore.update(
      await _db,
      trip.toJson(),
      finder: finder,
    );
  }

  @override
  Future<void> delete(Trip trip) async {
    final finder = Finder(filter: Filter.byKey(trip.tripId));
    await _tripsStore.delete(
      await _db,
      finder: finder,
    );
  }

  @override
  Future<List<Trip>> getAllTrips() async {
    final recordSnapshots = await _tripsStore.find(await _db);
    return recordSnapshots.map((snapshot) {
      print('>>> 1');
      final trip = Trip.fromJson(snapshot.value);
      print('>>> 2');
      return trip.copyWith(tripId: snapshot.key);
    }).toList();
  }
}

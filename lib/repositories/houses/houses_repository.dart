import '../../models/house.dart';
import '../../providers/database_provider.dart';

abstract class HousesRepository {
  DatabaseProvider databaseProvider;

  Future<House> insert(House house);
  Future<House> update(House house);
  Future<House> delete(House house);
  Future<List<House>> getHouses();
}

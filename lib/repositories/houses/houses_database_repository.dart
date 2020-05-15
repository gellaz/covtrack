import '../../dao/house_dao.dart';
import '../../models/house.dart';
import '../../providers/database_provider.dart';
import 'houses_repository.dart';

class HousesDatabaseRepository implements HousesRepository {
  final dao = HouseDao();

  @override
  DatabaseProvider databaseProvider;

  HousesDatabaseRepository(this.databaseProvider)
      : assert(databaseProvider != null);

  @override
  Future<House> insert(House house) async {
    final db = await databaseProvider.database;
    await db.insert(dao.tableName, dao.toMap(house));
    return house;
  }

  @override
  Future<House> update(House house) async {
    final db = await databaseProvider.database;
    await db.update(
      dao.tableName,
      dao.toMap(house),
      where: dao.columnPlaceId + ' = ?',
      whereArgs: [house.placeId],
    );
    return house;
  }

  @override
  Future<House> delete(House house) async {
    final db = await databaseProvider.database;
    await db.delete(
      dao.tableName,
      where: dao.columnPlaceId + ' = ?',
      whereArgs: [house.placeId],
    );
    return house;
  }

  @override
  Future<List<House>> getHouses() async {
    final db = await databaseProvider.database;
    List<Map> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}

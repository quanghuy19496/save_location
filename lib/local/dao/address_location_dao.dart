

import 'package:save_location/local/app_database.dart';
import 'package:save_location/local/tables/address_location_table.dart';

import 'base_dao.dart';

class AddressLocationDao extends BaseDao<AddressLocationTable> {
  static AddressLocationDao? _instance;

  AddressLocationDao._();

  factory AddressLocationDao() => _instance ??= AddressLocationDao._();

  void init() {
    db = AppDatabase().database!;
  }

  Future<int> insert({
    required String id,
    required String long,
    required String lat,
  }) async {
    await db.delete(AddressLocationTable.tableName);
    final categoriesTable =
    AddressLocationTable.fromParam(id: id, long: long, lat: lat);
    final item =
        await db.insert(AddressLocationTable.tableName, categoriesTable.toJson());

    return item;
  }

  Future<List<AddressLocationTable>?> getLocationList() async {
    List<AddressLocationTable> list = [];
    List<Map> maps = await db.query(AddressLocationTable.tableName, columns: [
      AddressLocationTable.columnId,
      AddressLocationTable.columnLong,
      AddressLocationTable.columnLat,
    ]);

    if (maps.isNotEmpty) {
      list = AddressLocationTable.fromJsonList(maps);

      return list;
    }

    return null;
  }
}

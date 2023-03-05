import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'tables/address_location_table.dart';

class AppDatabase {
  static const String databaseName = "test_project.db";
  static const int databaseVersion = 1;
  Database? _database;

  Database? get database => _database;

  static AppDatabase? _instance;

  /// Constructor
  AppDatabase._();

  factory AppDatabase() {
    return _instance ??= AppDatabase._();
  }

  Future<Database?> onInit() async {
    if (_database == null) {
      var databasesPath = await getDatabasesPath();
      var path = join(databasesPath, databaseName);
      _database = await openDatabase(
        path,
        version: databaseVersion,
        onCreate: (db, version) async {
          await db.execute(AddressLocationTable.create());
        },
      );
    }

    return _database;
  }
}

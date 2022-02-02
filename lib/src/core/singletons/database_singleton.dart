import '../../data/datasource/database/database.dart';

class DatabaseSingleton {
  factory DatabaseSingleton() {
    return _singleton;
  }

  DatabaseSingleton._internal();

  static final DatabaseSingleton _singleton = DatabaseSingleton._internal();

  static late AppDatabase database;
}

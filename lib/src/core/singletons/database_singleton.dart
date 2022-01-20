import '../../data/datasource/database/database.dart';

class DatabaseSingleton {
  static final DatabaseSingleton _singleton = DatabaseSingleton._internal();

  static late AppDatabase database;

  factory DatabaseSingleton() {
    return _singleton;
  }

  DatabaseSingleton._internal();
}

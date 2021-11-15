import 'package:compras_app/database/tables/item.dart';
import 'package:compras_app/database/tables/shopping_list.dart';
import 'package:moor/backends.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart';

import 'DAO/shopping_list_dao.dart';

part 'database.g.dart';

@UseMoor(
  tables: [ShoppingListTable, ItemTable],
  daos: [ShoppingListDao],
  queries: {},
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) => m.createAll(),
      onUpgrade: (m, from, to) async {
        if (from <= 1) {
          await m.alterTable(TableMigration(shoppingListTable));
        }
      });
}

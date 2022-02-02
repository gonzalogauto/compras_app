import 'package:moor_flutter/moor_flutter.dart';

import 'DAO/shopping_list_dao.dart';
import 'tables/item.dart';
import 'tables/shopping_list.dart';

part 'database.g.dart';

@UseMoor(
  tables: [ShoppingListTable, ItemTable],
  daos: [ShoppingListDao],
  queries: {},
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite',
            logStatements: true,
          ),
        );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) => m.createAll(),
        // onUpgrade: (m, from, to) async {
        //   if (from <= 1) {
        //     await m.alterTable(TableMigration(shoppingListTable));
        //   }
        //   if (from <= 2) {
        //     await m.alterTable(TableMigration(itemTable));
        //   }
        // },
      );
}

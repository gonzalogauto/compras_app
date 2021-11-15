import 'package:moor/moor.dart';

class ItemTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  IntColumn get shoppingListId => integer().nullable()();
  BoolColumn get isChecked => boolean().withDefault(const Constant(false))();
}

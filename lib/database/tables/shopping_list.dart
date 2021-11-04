import 'package:moor/moor.dart';

class ShoppingListTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

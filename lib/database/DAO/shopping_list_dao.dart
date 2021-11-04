import 'package:compras_app/database/tables/item.dart';
import 'package:compras_app/database/tables/shopping_list.dart';
import 'package:compras_app/models/shopping_list.dart';
import 'package:moor/moor.dart';

import '../database.dart';

part 'shopping_list_dao.g.dart';

@UseDao(tables: [ShoppingListTable, ItemTable])
class ShoppingListDao extends DatabaseAccessor<AppDatabase>
    with _$ShoppingListDaoMixin {
  ShoppingListDao(AppDatabase db) : super(db);

  Future<List<ShoppingList>> getShoppingList() async {
    final result = await select(shoppingListTable).get();
    return result
        .map((e) => ShoppingList(
            id: e.id,
            createdAt: e.createdAt,
            name: e.name ?? 'sin nombre',
            items: []))
        .toList();
  }

  Future<int> deleteShoppingList(int listId) async {
    await (delete(itemTable)..where((tbl) => tbl.shoppingListId.equals(listId)))
        .go();
    final result = await (select(shoppingListTable)
          ..where((u) => u.id.equals(listId)))
        .getSingle();
    return await delete(shoppingListTable).delete(result);
  }

  Stream<List<ShoppingListTableData>> watchShoppingList() {
    return select(shoppingListTable).watch();
  }

  Stream<List<ItemTableData>> watchItemsFromShoppingList(int listId) {
    return (select(itemTable)
          ..where((tbl) => tbl.shoppingListId.equals(listId)))
        .watch();
  }

  Future insertItem(Insertable<ItemTableData> item) {
    return into(itemTable).insert(item);
  }

  Future updateItem(Insertable<ItemTableData> item) {
    return update(itemTable).replace(item);
  }

  Future<int> deleteItem(int itemId) async {
    final result = await (select(itemTable)..where((u) => u.id.equals(itemId)))
        .getSingle();
    return await delete(itemTable).delete(result);
  }

  Future insertShoppingList(Insertable<ShoppingListTableData> shopppingList) {
    return into(shoppingListTable).insert(shopppingList);
  }

  Future<int> deleteAllShoppingLists() {
    return delete(shoppingListTable).go();
  }
}

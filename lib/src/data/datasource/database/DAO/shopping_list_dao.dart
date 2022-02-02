import 'package:moor/moor.dart';

import '../../../models/item_model.dart';
import '../../../models/shopping_list_model.dart';
import '../database.dart';
import '../tables/item.dart';
import '../tables/shopping_list.dart';

part 'shopping_list_dao.g.dart';

@UseDao(tables: [ShoppingListTable, ItemTable])
class ShoppingListDao extends DatabaseAccessor<AppDatabase>
    with _$ShoppingListDaoMixin {
  ShoppingListDao(AppDatabase db) : super(db);

  Future<List<ShoppingListModel>> getShoppingList() async {
    final result = await select(shoppingListTable).get();
    return result
        .map(
          (e) => ShoppingListModel(
            id: e.id,
            createdAt: e.createdAt,
            name: e.name ?? 'sin nombre',
            items: [],
          ),
        )
        .toList();
  }

  Future updateList(Insertable<ShoppingListTableData> data) {
    return update(shoppingListTable).replace(data);
  }

  Future<int> deleteShoppingList(int listId) async {
    await (delete(itemTable)..where((tbl) => tbl.shoppingListId.equals(listId)))
        .go();
    final result = await (select(shoppingListTable)
          ..where((u) => u.id.equals(listId)))
        .getSingle();
    return delete(shoppingListTable).delete(result);
  }

  Stream<List<ShoppingListModel>> watchShoppingList() {
    return select(shoppingListTable).watch().map(
          (event) => event
              .map(
                (e) => ShoppingListModel(
                  id: e.id,
                  createdAt: e.createdAt,
                  name: e.name,
                ),
              )
              .toList(),
        );
  }

  Stream<List<ItemModel>> watchItemsFromShoppingList(int listId) {
    return (select(itemTable)
          ..where((tbl) => tbl.shoppingListId.equals(listId)))
        .watch()
        .map(
          (event) => event
              .map(
                (e) => ItemModel(
                  id: e.id,
                  description: e.name,
                  isChecked: e.isChecked,
                ),
              )
              .toList(),
        );
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
    return delete(itemTable).delete(result);
  }

  Future insertShoppingList(Insertable<ShoppingListTableData> shopppingList) {
    return into(shoppingListTable).insert(shopppingList);
  }

  Future<int> deleteAllShoppingLists() {
    return delete(shoppingListTable).go();
  }
}

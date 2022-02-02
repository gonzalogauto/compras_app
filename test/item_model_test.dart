import 'package:compras_app/src/data/models/item_model.dart';
import 'package:compras_app/src/data/models/shopping_list_model.dart';
import 'package:compras_app/src/domain/entities/item.dart';
import 'package:compras_app/src/domain/entities/shopping_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Item test', () {
    final item = Item(id: 1);
    expect(item.id, 1);
    expect(item.description, null);
    final newItem = item.copyWith(description: 'test');
    expect(newItem.description, 'test');
  });

  test('ItemModel test', () {
    final itemModel = ItemModel(id: 1);
    expect(itemModel.id, 1);
    expect(itemModel.description, null);
    final newItemModel = itemModel.copyWith(description: 'test');
    expect(newItemModel.description, 'test');
  });

  test('ShoppingList test', () {
    final shoppingList = ShoppingList(
      id: 1,
      name: 'test',
      items: [],
      createdAt: DateTime.now(),
    );
    expect(shoppingList.id, 1);
    expect(shoppingList.name, 'test');
    final newShoppintList = shoppingList.copyWith(name: 'test1');
    expect(newShoppintList.name, 'test1');
  });
  test('ShoppingListModel test', () {
    final shoppingListModel = ShoppingListModel(id: 1);
    expect(shoppingListModel.id, 1);
    expect(shoppingListModel.name, null);
    final newShoppintListModel = shoppingListModel.copyWith(name: 'test');
    expect(newShoppintListModel.name, 'test');
  });
}

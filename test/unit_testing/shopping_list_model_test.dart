import 'package:compras_app/src/data/models/shopping_list_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final shoppingListModel = ShoppingListModel(id: 1);

  group('ShoppingListModel', () {
    test('ShoppingListModel test', () {
      expect(shoppingListModel.id, 1);
      expect(shoppingListModel.name, null);
    });

    test('ShoppingListModel.copyWith() test', () {
      final newShoppintListModel = shoppingListModel.copyWith(name: 'test');
      expect(newShoppintListModel.name, 'test');
    });

    test('ShoppingListModel.toString() test', () {
      expect(shoppingListModel.toString(), isA<String>());
    });
  });
}

import 'package:compras_app/src/domain/entities/shopping_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final shoppingList = ShoppingList(
    id: 1,
    name: 'test',
    items: [],
    createdAt: DateTime.now(),
  );
  group('ShoppingList', () {
    test('ShoppingList test', () {
      expect(shoppingList.id, 1);
      expect(shoppingList.name, 'test');
    });
    test('ShoppingList.copyWith() test', () {
      final newShoppintList = shoppingList.copyWith(name: 'test1');
      expect(newShoppintList.name, 'test1');
    });

    test('ShoppingList.toString() test', () {
      expect(shoppingList.toString(), isA<String>());
    });
  });
}

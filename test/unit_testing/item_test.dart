import 'package:compras_app/src/domain/entities/item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final item = Item(id: 1, description: 'desc');

  group('Item', () {
    test('Item test', () {
      expect(item.id, 1);
      expect(item.description, 'desc');
    });
    test('Item.copyWith() test', () {
      final newItem = item.copyWith(description: 'test');
      expect(newItem.description, 'test');
    });
    test('Item.toString() test', () {
      expect(item.toString(), isA<String>());
    });
  });
}

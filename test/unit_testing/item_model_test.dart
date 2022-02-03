import 'package:compras_app/src/data/models/item_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final itemModel = ItemModel(id: 1, description: 'desc');
  group('ItemModel', () {
    test('ItemModel test', () {
      expect(itemModel.id, 1);
      expect(itemModel.description, 'desc');
    });

    test('ItemModel.copyWith() test', () {
      final newItemModel = itemModel.copyWith(description: 'test');
      expect(newItemModel.description, 'test');
    });

    test('ItemModel.toString() test', () {
      expect(itemModel.toString(), isA<String>());
    });
  });
}

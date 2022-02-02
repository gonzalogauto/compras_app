import 'item.dart';

class ShoppingList {
  ShoppingList({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.items,
  });

  final int? id;
  final DateTime? createdAt;
  final String? name;
  final List<Item>? items;

  @override
  String toString() {
    return 'ShoppingList(id: $id, createdAt: $createdAt'
        ',name: $name, items: $items)';
  }

  ShoppingList copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    List<Item>? items,
  }) {
    return ShoppingList(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }
}

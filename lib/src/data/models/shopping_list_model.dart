import '../../domain/entities/item.dart';
import '../../domain/entities/shopping_list.dart';

class ShoppingListModel extends ShoppingList {
  ShoppingListModel({
    int? id,
    DateTime? createdAt,
    String? name,
    List<Item>? items,
  }) : super(
          id: id,
          createdAt: createdAt,
          name: name,
          items: items,
        );

  @override
  ShoppingListModel copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    List<Item>? items,
  }) {
    return ShoppingListModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }
}

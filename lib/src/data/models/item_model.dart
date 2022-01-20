import '../../domain/entities/item.dart';

class ItemModel extends Item {
  ItemModel({
    int? id,
    String? description,
    num? quantity,
    num? unitPrice,
    bool? isChecked,
  }) : super(
            id: id,
            description: description,
            quantity: quantity,
            unitPrice: unitPrice,
            isChecked: isChecked);

  @override
  ItemModel copyWith({
    int? id,
    String? description,
    num? quantity,
    num? unitPrice,
    bool? isChecked,
  }) {
    return ItemModel(
      id: id ?? this.id,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}

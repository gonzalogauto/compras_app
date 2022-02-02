class Item {
  Item({
    this.id,
    this.description,
    this.quantity,
    this.unitPrice,
    this.isChecked,
  });

  final int? id;
  final String? description;
  final num? quantity;
  final num? unitPrice;
  final bool? isChecked;

  @override
  String toString() {
    return 'Item(id: $id, description: $description, quantity: $quantity'
        ', unit_price: $unitPrice)';
  }

  Item copyWith({
    int? id,
    String? description,
    num? quantity,
    num? unitPrice,
    bool? isChecked,
  }) {
    return Item(
      id: id ?? this.id,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}

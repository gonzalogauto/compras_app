class Item {
  final int id;
  final String description;
  final num quantity;
  final num unitPrice;
  Item({
    required this.id,
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  @override
  String toString() {
    return 'Item(id: $id, description: $description, quantity: $quantity, unit_price: $unitPrice)';
  }
}

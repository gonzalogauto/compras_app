part of 'items_bloc.dart';

@immutable
abstract class ItemsEvent {}

class GetItemsEvent extends ItemsEvent {}

class AddItemEvent extends ItemsEvent {
  final String name;
  final int? quantity;
  final num? unitPrice;
  final int listId;
  AddItemEvent(
      {required this.name,
      this.quantity,
      this.unitPrice,
      required this.listId});
}

class UpdateItemEvent extends ItemsEvent {
  final Insertable<ItemTableData> item;
  UpdateItemEvent({required this.item});
}

class DeleteItemEvent extends ItemsEvent {
  final int id;
  DeleteItemEvent({required this.id});
}

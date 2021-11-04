part of 'shopping_list_bloc.dart';

@immutable
abstract class ShoppingListEvent {}

class ShoppingListSearchAll extends ShoppingListEvent {}

class ShoppingListInsertItem extends ShoppingListEvent {}

class ShoppingListUpdateItem extends ShoppingListEvent {}

class ShoppingListDeleteItem extends ShoppingListEvent {}

class ShoppingListCreate extends ShoppingListEvent {
  final String name;
  ShoppingListCreate({required this.name});
}

class ShoppingListUpdate extends ShoppingListEvent {}

class ShoppingListDelete extends ShoppingListEvent {
  final int id;
  ShoppingListDelete({required this.id});
}

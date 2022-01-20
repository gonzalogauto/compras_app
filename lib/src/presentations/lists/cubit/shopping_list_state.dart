part of 'shopping_list_cubit.dart';

class ShoppingListState {
  ShoppingListState({this.data, required this.status});
  final Status status;
  final List<ShoppingList>? data;

  List<Object?> get props => [status, data];

  ShoppingListState copyWith({
    Status? status,
    List<ShoppingList>? data,
  }) {
    return ShoppingListState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}

part of 'items_cubit.dart';

class ItemsState {
  ItemsState({this.data, required this.status});
  final Status status;
  final List<Item>? data;

  List<Object?> get props => [status, data];

  ItemsState copyWith({
    Status? status,
    List<Item>? data,
  }) {
    return ItemsState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}

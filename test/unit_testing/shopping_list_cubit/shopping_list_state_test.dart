import 'package:compras_app/src/core/commons/status_enum.dart';
import 'package:compras_app/src/presentations/lists/cubit/shopping_list_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ShoppingListState.copyWith() test', () {
    final itemState = ShoppingListState(status: Status.initial);
    expect(itemState.copyWith().status, itemState.status);
  });

  test('ShoppingListState.props test', () {
    final itemState = ShoppingListState(status: Status.initial);
    expect(itemState.props, isA<List<Object?>>());
  });
}

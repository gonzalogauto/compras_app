import 'package:compras_app/src/core/commons/status_enum.dart';
import 'package:compras_app/src/presentations/detail/cubit/items_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ItemsState', () {
    final itemState = ItemsState(status: Status.initial);
    expect(itemState.copyWith().status, itemState.status);
  });

  test('ItemsState', () {
    final itemState = ItemsState(status: Status.initial);
    expect(itemState.props, isA<List<Object?>>());
  });
}

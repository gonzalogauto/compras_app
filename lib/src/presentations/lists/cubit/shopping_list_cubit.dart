import 'package:bloc/bloc.dart';
import 'package:compras_app/src/core/commons/status_enum.dart';
import 'package:compras_app/src/core/locator.dart';
import 'package:compras_app/src/data/datasource/database/DAO/shopping_list_dao.dart';
import 'package:compras_app/src/data/datasource/database/database.dart';
import 'package:compras_app/src/domain/entities/shopping_list.dart';
import 'package:moor/moor.dart' as moor;
import 'package:moor/moor.dart';

part 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  ShoppingListCubit() : super(ShoppingListState(status: Status.initial));

  ShoppingListDao get dao => locator.get<AppDatabase>().shoppingListDao;

  Future<void> fetchAll() async {
    emit(state.copyWith(status: Status.loading));
    final data = await dao.getShoppingList();
    emit(state.copyWith(status: Status.loaded, data: data));
  }

  Future<void> createList(String name) async {
    await dao.insertShoppingList(
      ShoppingListTableCompanion(
        name: moor.Value(name),
        createdAt: moor.Value(DateTime.now()),
      ),
    );
    final data = await dao.getShoppingList();
    emit(state.copyWith(status: Status.loaded, data: data));
  }

  Future<void> updateList(Insertable<ShoppingListTableData> list) async {
    await dao.updateList(list);
    final data = await dao.getShoppingList();
    emit(state.copyWith(status: Status.loaded, data: data));
  }

  Future<void> deleteList(int listId) async {
    await dao.deleteShoppingList(listId);
    final data = await dao.getShoppingList();
    emit(state.copyWith(status: Status.loaded, data: data));
  }
}

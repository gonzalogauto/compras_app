import 'package:bloc/bloc.dart';
import 'package:compras_app/commons/status_enum.dart';
import 'package:compras_app/database/DAO/shopping_list_dao.dart';
import 'package:compras_app/database/database.dart';
import 'package:compras_app/models/shopping_list.dart';
import 'package:compras_app/singletons/database_singleton.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart' as moor;

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListBloc() : super(ShoppingListState(status: Status.initial)) {
    on<ShoppingListSearchAll>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final data = await dao.getShoppingList();
      emit(state.copyWith(status: Status.loaded, data: data));
    });
    on<ShoppingListCreate>((event, emit) async {
      await dao.insertShoppingList(ShoppingListTableCompanion(
          name: moor.Value(event.name), createdAt: moor.Value(DateTime.now())));
      final data = await dao.getShoppingList();
      emit(state.copyWith(status: Status.loaded, data: data));
    });
    on<ShoppingListUpdate>((event, emit) {
      emit(state.copyWith(status: Status.loading));
    });
    on<ShoppingListDelete>((event, emit) async {
      await dao.deleteShoppingList(event.id);
      final data = await dao.getShoppingList();
      emit(state.copyWith(status: Status.loaded, data: data));
    });

    on<ShoppingListInsertItem>((event, emit) {
      emit(state.copyWith(status: Status.loading));
    });
    on<ShoppingListUpdateItem>((event, emit) {
      emit(state.copyWith(status: Status.loading));
    });
    on<ShoppingListDeleteItem>((event, emit) {
      emit(state.copyWith(status: Status.loading));
    });
  }

  ShoppingListDao get dao => DatabaseSingleton.database.shoppingListDao;
}

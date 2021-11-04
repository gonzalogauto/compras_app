import 'package:bloc/bloc.dart';
import 'package:compras_app/commons/status_enum.dart';
import 'package:compras_app/database/DAO/shopping_list_dao.dart';
import 'package:compras_app/database/database.dart';
import 'package:compras_app/models/item.dart';
import 'package:compras_app/singletons/database_singleton.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart' as moor;
import 'package:moor/moor.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(ItemsState(status: Status.initial)) {
    on<GetItemsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AddItemEvent>((event, emit) async {
      await dao.insertItem(ItemTableCompanion(
          name: moor.Value(event.name),
          shoppingListId: moor.Value(event.listId)));
    });
    on<UpdateItemEvent>((event, emit) async {
      await dao.updateItem(event.item);
    });
    on<DeleteItemEvent>((event, emit) async {
      await dao.deleteItem(event.id);
    });
  }
  ShoppingListDao get dao => DatabaseSingleton.database.shoppingListDao;
}

import 'package:bloc/bloc.dart';
import 'package:compras_app/src/core/commons/status_enum.dart';
import 'package:compras_app/src/core/locator.dart';
import 'package:compras_app/src/data/datasource/database/DAO/shopping_list_dao.dart';
import 'package:compras_app/src/data/datasource/database/database.dart';
import 'package:compras_app/src/data/models/item_model.dart';
import 'package:compras_app/src/domain/entities/item.dart';
import 'package:moor/moor.dart' as moor;

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  ItemsCubit() : super(ItemsState(status: Status.initial));

  ShoppingListDao get dao => locator.get<AppDatabase>().shoppingListDao;

  Future<void> addItem(String name, int listId) async {
    await dao.insertItem(
      ItemTableCompanion(
        name: moor.Value(name),
        shoppingListId: moor.Value(listId),
      ),
    );
  }

  Future<void> updateItem(ItemModel item) async {
    await dao.updateItem(
      ItemTableCompanion.insert(
        id: moor.Value<int>(item.id!),
        name: moor.Value(item.description),
        isChecked: moor.Value<bool>(item.isChecked!),
      ),
    );
  }

  Future<void> deleteItem(int itemId) async {
    await dao.deleteItem(itemId);
  }
}

import '../../../core/commons/actions_enum.dart';
import '../../../data/models/item_model.dart';
import '../cubit/items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'delete_item_dialog.dart';
import 'edit_item_dialog.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<ItemModel> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          child: ListTile(
            leading: Checkbox(
              side: BorderSide(color: Colors.grey.shade500, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              value: items[index].isChecked,
              onChanged: (value) => context.read<ItemsCubit>().updateItem(
                    items[index].copyWith(
                      isChecked: value,
                    ),
                  ),
            ),
            title: Text(
              items[index].description!,
              style: items[index].isChecked!
                  ? GoogleFonts.lato(decoration: TextDecoration.lineThrough)
                  : GoogleFonts.lato(),
            ),
            trailing: PopupMenuButton<AppAction>(
              onSelected: (item) async {
                switch (item) {
                  case AppAction.edit:
                    return await showDialog(
                      context: context,
                      builder: (context) => EditItemDialog(
                        itemData: items[index],
                      ),
                    );
                  case AppAction.remove:
                    return await showDialog(
                      context: context,
                      builder: (context) => DeleteItemDialog(
                        itemData: items[index],
                      ),
                    );
                  default:
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Text('Editar'),
                  value: AppAction.edit,
                ),
                const PopupMenuItem(
                  child: Text('Borrar'),
                  value: AppAction.remove,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

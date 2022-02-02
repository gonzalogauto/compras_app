import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/commons/actions_enum.dart';
import '../../../data/models/item_model.dart';
import '../cubit/items_cubit.dart';

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
      itemCount: items.length + 1,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (context, index) {
        if (index == (items.length)) return const SizedBox(height: 80);
        return Card(
          elevation: 0,
          child: ListTile(
            leading: Checkbox(
              side: BorderSide(color: Colors.grey.shade500),
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
                    return showDialog(
                      context: context,
                      builder: (context) => EditItemDialog(
                        itemData: items[index],
                      ),
                    );
                  case AppAction.remove:
                    return showDialog(
                      context: context,
                      builder: (context) => DeleteItemDialog(
                        itemData: items[index],
                      ),
                    );
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: AppAction.edit,
                  child: Text(AppLocalizations.of(context)!.edit),
                ),
                PopupMenuItem(
                  value: AppAction.remove,
                  child: Text(AppLocalizations.of(context)!.delete),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

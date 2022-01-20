import '../../../core/commons/actions_enum.dart';
import '../../../core/commons/argument_data.dart';
import '../../../data/models/shopping_list_model.dart';
import '../../detail/screen/list_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'delete_list_dialog.dart';
import 'edit_list_dialog.dart';

class ListOfShoppingLists extends StatelessWidget {
  const ListOfShoppingLists({
    Key? key,
    required this.shoppingLists,
  }) : super(key: key);

  final List<ShoppingListModel> shoppingLists;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: shoppingLists.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            shoppingLists[index].name!,
            style: GoogleFonts.lato(fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
              DateFormat('dd/MM/yyyy').format(shoppingLists[index].createdAt!),
              style: GoogleFonts.lato()),
          trailing: PopupMenuButton<AppAction>(
              onSelected: (item) async {
                switch (item) {
                  case AppAction.edit:
                    return await showDialog(
                        context: context,
                        builder: (context) => EditListDialog(
                              listData: shoppingLists[index],
                            ));
                  case AppAction.remove:
                    return await showDialog(
                        context: context,
                        builder: (context) => DeleteListDialog(
                              listData: shoppingLists[index],
                            ));
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
                  ]),
          onTap: () {
            Navigator.pushNamed(context, DetailPage.routeName,
                arguments: ArgumentData(
                    id: shoppingLists[index].id!,
                    name: shoppingLists[index].name!));
          },
        );
      },
    );
  }
}

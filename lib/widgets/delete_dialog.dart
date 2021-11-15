import 'package:compras_app/bloc/shopping_list_bloc.dart';
import 'package:compras_app/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class DeleteListDialog extends StatelessWidget {
  final ShoppingListTableData listData;
  const DeleteListDialog({required this.listData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '¿Desea borrar la lista "${listData.name!}"?',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('NO')),
                ElevatedButton(
                    onPressed: () {
                      context
                          .read<ShoppingListBloc>()
                          .add(ShoppingListDelete(id: listData.id));
                      Navigator.pop(context);
                    },
                    child: const Text('SI'))
              ],
            )
          ],
        ),
      ),
    );
  }
}

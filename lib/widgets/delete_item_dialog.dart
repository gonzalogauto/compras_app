import 'package:compras_app/bloc/items_bloc.dart';
import 'package:compras_app/database/database.dart';
import 'package:compras_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class DeleteItemDialog extends StatelessWidget {
  final ItemTableData itemData;
  const DeleteItemDialog({required this.itemData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '¿Desea borrar el item?',
              style: TextStyle(fontSize: 20),
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
                          .read<ItemsBloc>()
                          .add(DeleteItemEvent(id: itemData.id));
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

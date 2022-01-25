import '../../../data/models/shopping_list_model.dart';
import '../cubit/shopping_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteListDialog extends StatelessWidget {
  const DeleteListDialog({
    Key? key,
    required this.listData,
  }) : super(key: key);

  final ShoppingListModel listData;

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
                  child: Text(
                    AppLocalizations.of(context)!.no.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onPressed: () {
                      context
                          .read<ShoppingListCubit>()
                          .deleteList(listData.id!);
                      Navigator.pop(context);
                    },
                    child:
                        Text(AppLocalizations.of(context)!.yes.toUpperCase()))
              ],
            )
          ],
        ),
      ),
    );
  }
}

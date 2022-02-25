import 'package:compras_app/src/data/models/item_model.dart';
import 'package:compras_app/src/presentations/detail/cubit/items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteItemDialog extends StatelessWidget {
  const DeleteItemDialog({
    Key? key,
    required this.itemData,
  }) : super(key: key);

  final ItemModel itemData;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context).colorScheme;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.doYouWhatToDeleteThisItem,
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
                    style: TextStyle(color: _theme.secondary),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      _theme.secondary,
                    ),
                  ),
                  onPressed: () {
                    context.read<ItemsCubit>().deleteItem(itemData.id!);
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.yes.toUpperCase(),
                    style: TextStyle(color: _theme.onSecondary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

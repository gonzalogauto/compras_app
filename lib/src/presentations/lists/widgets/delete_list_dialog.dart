import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/models/shopping_list_model.dart';
import '../cubit/shopping_list_cubit.dart';

class DeleteListDialog extends StatelessWidget {
  const DeleteListDialog({
    Key? key,
    required this.listData,
  }) : super(key: key);

  final ShoppingListModel listData;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context).colorScheme;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.doYouWhatToDeleteThisList,
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
                      color: _theme.secondary,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      _theme.secondary,
                    ),
                  ),
                  onPressed: () {
                    context.read<ShoppingListCubit>().deleteList(listData.id!);
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

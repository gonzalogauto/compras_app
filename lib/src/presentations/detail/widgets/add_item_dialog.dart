import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddItemDialog extends StatelessWidget {
  AddItemDialog({Key? key}) : super(key: key);
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context).colorScheme;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.newItem,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
                labelStyle: TextStyle(
                  color: _theme.secondary,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _theme.secondary,
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    _textEditingController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancel.toUpperCase(),
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
                    Navigator.pop(context, _textEditingController.text);
                    _textEditingController.clear();
                  },
                  child:
                      Text(AppLocalizations.of(context)!.accept.toUpperCase()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

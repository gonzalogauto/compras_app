import '../../../data/models/item_model.dart';
import '../cubit/items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditItemDialog extends StatelessWidget {
  EditItemDialog({
    Key? key,
    required this.itemData,
  }) : super(key: key);

  final ItemModel itemData;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context).colorScheme;
    _nameController.text = itemData.description ?? '';
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.insertTheNewNameOfTheItem,
                style: GoogleFonts.lato(fontSize: 17),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                validator: (value) => value != ''
                    ? null
                    : AppLocalizations.of(context)!.youMustCompleteThisField,
                autofocus: true,
                style: GoogleFonts.lato(fontSize: 17),
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
                      _nameController.clear();
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.cancel.toUpperCase(),
                      style: GoogleFonts.lato(
                        fontSize: 12,
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
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<ItemsCubit>().updateItem(itemData.copyWith(
                              description: _nameController.text,
                            ));
                        _nameController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.save.toUpperCase(),
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        color: _theme.onSecondary,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

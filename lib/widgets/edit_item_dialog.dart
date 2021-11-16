import 'package:compras_app/bloc/items_bloc.dart';
import 'package:compras_app/database/database.dart';
import 'package:compras_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:moor/moor.dart' as moor;

class EditItemDialog extends StatelessWidget {
  final ItemTableData itemData;
  EditItemDialog({required this.itemData, Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    _nameController.text = itemData.name ?? '';
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
                'Ingrese el nuevo nombre del item',
                style: GoogleFonts.lato(fontSize: 17),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                  controller: _nameController,
                  validator: (value) =>
                      value != '' ? null : 'Debe completar el campo',
                  autofocus: true,
                  style: GoogleFonts.lato(fontSize: 17),
                  decoration: const InputDecoration(
                      labelText: 'Nombre', border: OutlineInputBorder())),
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
                        'CANCELAR',
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary,
                      )),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ItemsBloc>().add(UpdateItemEvent(
                                  item: ItemTableCompanion(
                                id: moor.Value(itemData.id),
                                name: moor.Value(_nameController.text),
                                isChecked: moor.Value(itemData.isChecked),
                                shoppingListId:
                                    moor.Value(itemData.shoppingListId),
                              )));
                          _nameController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'GUARDAR',
                        style: GoogleFonts.lato(fontSize: 12),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

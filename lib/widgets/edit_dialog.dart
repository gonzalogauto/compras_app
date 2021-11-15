import 'package:compras_app/bloc/shopping_list_bloc.dart';
import 'package:compras_app/database/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moor/moor.dart' as moor;
import 'package:provider/src/provider.dart';

class EditListDialog extends StatelessWidget {
  final ShoppingListTableData listData;
  EditListDialog({required this.listData, Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                'Ingrese el nuevo nombre de la lista',
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
                        style: GoogleFonts.lato(fontSize: 12),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ShoppingListBloc>().add(
                              ShoppingListUpdate(
                                  report: ShoppingListTableCompanion(
                                      id: moor.Value(listData.id),
                                      name: moor.Value(_nameController.text))));
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

import 'package:flutter/material.dart';

class AddListDialog extends StatelessWidget {
  AddListDialog({Key? key}) : super(key: key);
  final TextEditingController _textEditingController = TextEditingController();

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
              'Nueva lista de compras',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _textEditingController,
              autofocus: true,
              decoration: const InputDecoration(
                  labelText: 'Nombre', border: OutlineInputBorder()),
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
                      'CANCELAR',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary,
                    )),
                    onPressed: () {
                      Navigator.pop(context, _textEditingController.text);
                      _textEditingController.clear();
                    },
                    child: const Text('ACEPTAR'))
              ],
            )
          ],
        ),
      ),
    );
  }
}

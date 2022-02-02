import '../../lists/cubit/shopping_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_list_dialog.dart';

class NewListButton extends StatelessWidget {
  const NewListButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: () async {
        final listName = await showDialog<String>(
          context: context,
          builder: (context) => AddListDialog(),
        );
        if (listName != null) {
          await context.read<ShoppingListCubit>().createList(listName);
        }
      },
      child: const Icon(Icons.add),
    );
  }
}

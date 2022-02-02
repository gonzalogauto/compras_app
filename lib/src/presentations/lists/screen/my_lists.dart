import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/locator.dart';
import '../../../core/widgets/empty_widget.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../data/datasource/database/database.dart';
import '../../../data/models/shopping_list_model.dart';
import '../cubit/shopping_list_cubit.dart';
import '../widgets/shopping_list.dart';

class MyListPage extends StatelessWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShoppingListCubit(),
      child: const MyListsPage(),
    );
  }
}

class MyListsPage extends StatelessWidget {
  const MyListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: locator.get<AppDatabase>().shoppingListDao.watchShoppingList(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<ShoppingListModel>> snapshot,
        ) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const LoadingWidget();
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) return const CustomEmptyWidget();
            return ListOfShoppingLists(
              shoppingLists: snapshot.data!,
            );
          } else {
            return const CustomErrorWidget();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/commons/argument_data.dart';
import '../../../core/locator.dart';
import '../../../core/widgets/empty_widget.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../data/datasource/database/database.dart';
import '../../../data/models/item_model.dart';
import '../cubit/items_cubit.dart';
import '../widgets/add_item_dialog.dart';
import '../widgets/items_list.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    this.args,
  }) : super(key: key);

  final ArgumentData? args;
  static const routeName = '/detailPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemsCubit(),
      child: DetailPageView(
        args: args,
      ),
    );
  }
}

class DetailPageView extends StatelessWidget {
  DetailPageView({
    Key? key,
    this.args,
  }) : super(key: key);

  final ArgumentData? args;

  final dao = locator.get<AppDatabase>().shoppingListDao;
  final List<ItemModel> data = [];

  Future<void> _share(String listName) async {
    var text = '*$listName*:\n';
    for (final item in data) {
      if (item.isChecked!) {
        text += '• ~${item.description}~.\n';
      } else {
        text += '• ${item.description}.\n';
      }
    }
    await Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ArgumentData?;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          args!.name,
          style: GoogleFonts.lato(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: () => _share(
              args.name,
            ),
            icon: Icon(
              Icons.share,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: dao.watchItemsFromShoppingList(args.id),
        builder:
            (BuildContext context, AsyncSnapshot<List<ItemModel>> snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const LoadingWidget();
          } else if (snapshot.hasData) {
            data
              ..clear()
              ..addAll(snapshot.data!);
            if (snapshot.data!.isNotEmpty) {
              return ItemsList(items: snapshot.data!);
            } else {
              return const CustomEmptyWidget();
            }
          } else {
            return const CustomErrorWidget();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          final listName = await showDialog<String>(
            context: context,
            builder: (context) => AddItemDialog(),
          );

          if (listName == null) return;

          await context.read<ItemsCubit>().addItem(
                listName,
                args.id,
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

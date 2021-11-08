import 'package:compras_app/bloc/items_bloc.dart';
import 'package:compras_app/commons/actions_enum.dart';
import 'package:compras_app/commons/actions_enum.dart';
import 'package:compras_app/commons/actions_enum.dart';
import 'package:compras_app/commons/actions_enum.dart';
import 'package:compras_app/database/database.dart';
import 'package:compras_app/singletons/database_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'my_lists.dart';

class DetailPage extends StatelessWidget {
  final ArgumentData? args;
  const DetailPage({this.args, Key? key}) : super(key: key);
  static const routeName = '/detailPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemsBloc(),
      child: DetailPageView(
        args: args,
      ),
    );
  }
}

class DetailPageView extends StatefulWidget {
  final ArgumentData? args;
  const DetailPageView({this.args, Key? key}) : super(key: key);

  @override
  _DetailPageViewState createState() => _DetailPageViewState();
}

class _DetailPageViewState extends State<DetailPageView> {
  final TextEditingController _textEditingController = TextEditingController();
  final dao = DatabaseSingleton.database.shoppingListDao;
  List<ItemTableData> data = [];

  Future<void> _share(String listName) async {
    var text = '*$listName*:\n';
    for (var item in data) {
      if (item.isChecked) {
        text += '• ~${item.name}~.\n';
      } else {
        text += '• ${item.name}.\n';
      }
    }
    await Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ArgumentData;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.name, style: GoogleFonts.lato()),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _share(
                    args.name,
                  ),
              icon: const Icon(Icons.share))
        ],
      ),
      body: StreamBuilder(
          stream: dao.watchItemsFromShoppingList(args.id),
          builder: (BuildContext context,
              AsyncSnapshot<List<ItemTableData>> snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              data.clear();
              data.addAll(snapshot.data!);
              if (snapshot.data!.isNotEmpty) {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Checkbox(
                        side: BorderSide(color: Colors.grey.shade500, width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        value: snapshot.data![index].isChecked,
                        onChanged: (value) {
                          context.read<ItemsBloc>().add(UpdateItemEvent(
                              item: snapshot.data![index]
                                  .copyWith(isChecked: value)));
                        },
                      ),
                      title: Text(snapshot.data![index].name!,
                          style: snapshot.data![index].isChecked
                              ? GoogleFonts.lato(
                                  decoration: TextDecoration.lineThrough)
                              : GoogleFonts.lato()),
                      trailing: PopupMenuButton<AppAction>(
                          onSelected: (item) async {
                            switch (item) {
                              case AppAction.edit:
                                break;
                              case AppAction.remove:
                                await showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  '¿Desea borrar el item?',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child:
                                                            const Text('NO')),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          context
                                                              .read<ItemsBloc>()
                                                              .add(DeleteItemEvent(
                                                                  id: snapshot
                                                                      .data![
                                                                          index]
                                                                      .id));
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text('SI'))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                                break;
                              default:
                            }
                          },
                          itemBuilder: (context) => [
                                // const PopupMenuItem(
                                //   child: Text('Editar'),
                                //   value: AppAction.edit,
                                // ),
                                const PopupMenuItem(
                                  child: Text('Borrar'),
                                  value: AppAction.remove,
                                ),
                              ]),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('Sin productos.'),
                );
              }
            }
          }),
      floatingActionButton: FloatingActionButton(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          final listName = await showDialog<String>(
              context: context,
              builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Nuevo item',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _textEditingController,
                            autofocus: true,
                            decoration: const InputDecoration(
                                labelText: 'Nombre',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('CANCELAR')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(
                                        context, _textEditingController.text);
                                  },
                                  child: const Text('ACEPTAR'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
          if (listName != null) {
            context.read<ItemsBloc>().add(
                  AddItemEvent(name: listName, listId: args.id),
                );
          }
          _textEditingController.clear();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

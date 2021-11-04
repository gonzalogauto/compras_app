import 'package:compras_app/singletons/database_singleton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:compras_app/bloc/shopping_list_bloc.dart';
import 'package:compras_app/database/database.dart';
import 'package:compras_app/screens/list_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyListPage extends StatelessWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShoppingListBloc(),
      child: const MyListsPage(),
    );
  }
}

class MyListsPage extends StatefulWidget {
  const MyListsPage({Key? key}) : super(key: key);

  @override
  _MyListsPageState createState() => _MyListsPageState();
}

class _MyListsPageState extends State<MyListsPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final dao = DatabaseSingleton.database.shoppingListDao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: dao.watchShoppingList(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ShoppingListTableData>> snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return snapshot.data!.isNotEmpty
                  ? ListView.separated(
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              color: Colors.red,
                            ),
                            onDismissed: (direction) {
                              context.read<ShoppingListBloc>().add(
                                  ShoppingListDelete(
                                      id: snapshot.data![index].id));
                            },
                            child: ListTile(
                              title: Text(
                                snapshot.data![index].name!,
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w400),
                              ),
                              subtitle: Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(snapshot.data![index].createdAt),
                                  style: GoogleFonts.lato()),
                              trailing: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, DetailPage.routeName,
                                    arguments: ArgumentData(
                                        id: snapshot.data![index].id,
                                        name: snapshot.data![index].name!));
                              },
                            ));
                      },
                    )
                  : const Center(
                      child: Text('Sin datos'),
                    );
            }
          }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   shape:
      //       BeveledRectangleBorder(borderRadius: BorderRadius.circular(50)),
      //   onPressed: () async {
      //     final listName = await showDialog<String>(
      //         context: context,
      //         builder: (context) => Dialog(
      //               shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(10)),
      //               child: Padding(
      //                 padding: const EdgeInsets.all(15.0),
      //                 child: Column(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: [
      //                     const Text(
      //                       'Nueva lista de compras',
      //                       style: TextStyle(fontSize: 20),
      //                     ),
      //                     const SizedBox(height: 20),
      //                     TextFormField(
      //                       controller: _textEditingController,
      //                       autofocus: true,
      //                       decoration: const InputDecoration(
      //                           labelText: 'Nombre',
      //                           border: OutlineInputBorder()),
      //                     ),
      //                     const SizedBox(height: 20),
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                       children: [
      //                         TextButton(
      //                             onPressed: () => Navigator.pop(context),
      //                             child: const Text('CANCELAR')),
      //                         ElevatedButton(
      //                             onPressed: () {
      //                               Navigator.pop(
      //                                   context, _textEditingController.text);
      //                             },
      //                             child: const Text('ACEPTAR'))
      //                       ],
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ));
      //     if (listName != null) {
      //       context.read<ShoppingListBloc>().add(
      //             ShoppingListCreate(name: listName),
      //           );
      //     }
      //     _textEditingController.clear();
      //   },
      //   // mini: true,
      //   child: const Icon(Icons.add),
      // ));
    );
  }
}

class ArgumentData {
  int id;
  String name;
  ArgumentData({required this.id, required this.name});
}

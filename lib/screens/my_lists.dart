import 'package:compras_app/commons/actions_enum.dart';
import 'package:compras_app/singletons/database_singleton.dart';
import 'package:compras_app/widgets/delete_list_dialog.dart';
import 'package:compras_app/widgets/edit_list_dialog.dart';
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
                        return ListTile(
                          title: Text(
                            snapshot.data![index].name!,
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.w400),
                          ),
                          subtitle: Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(snapshot.data![index].createdAt!),
                              style: GoogleFonts.lato()),
                          trailing: PopupMenuButton<AppAction>(
                              onSelected: (item) async {
                                switch (item) {
                                  case AppAction.edit:
                                    return await showDialog(
                                        context: context,
                                        builder: (context) => EditListDialog(
                                              listData: snapshot.data![index],
                                            ));
                                  case AppAction.remove:
                                    return await showDialog(
                                        context: context,
                                        builder: (context) => DeleteListDialog(
                                              listData: snapshot.data![index],
                                            ));
                                  default:
                                }
                              },
                              itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      child: Text('Editar'),
                                      value: AppAction.edit,
                                    ),
                                    const PopupMenuItem(
                                      child: Text('Borrar'),
                                      value: AppAction.remove,
                                    ),
                                  ]),
                          onTap: () {
                            Navigator.pushNamed(context, DetailPage.routeName,
                                arguments: ArgumentData(
                                    id: snapshot.data![index].id,
                                    name: snapshot.data![index].name!));
                          },
                        );
                      },
                    )
                  : const Center(
                      child: Text('Sin datos'),
                    );
            }
          }),
    );
  }
}

class ArgumentData {
  int id;
  String name;
  ArgumentData({required this.id, required this.name});
}

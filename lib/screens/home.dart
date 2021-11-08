import 'package:compras_app/bloc/shopping_list_bloc.dart';
import 'package:compras_app/screens/my_lists.dart';
import 'package:compras_app/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  //final dao = DatabaseSingleton.database.shoppingListDao;
  final PageController _pageController = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mis Compras App', style: GoogleFonts.lato()),
          elevation: 0,
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          allowImplicitScrolling: false,
          controller: _pageController,
          children: const [
            MyListPage(),
            SettingsPage(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: index == 0
            ? FloatingActionButton(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
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
                                    'Nueva lista de compras',
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('CANCELAR')),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context,
                                                _textEditingController.text);
                                          },
                                          child: const Text('ACEPTAR'))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ));
                  if (listName != null) {
                    context.read<ShoppingListBloc>().add(
                          ShoppingListCreate(name: listName),
                        );
                  }
                  _textEditingController.clear();
                },
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (newIndex) {
            setState(() {
              index = newIndex;
            });
            _pageController.animateToPage(newIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate);
          },
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: 'Listas'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Ajustes'),
          ],
        ));
  }
}

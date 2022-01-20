import '../widgets/add_list_dialog.dart';
import '../widgets/home_body.dart';
import '../../lists/cubit/shopping_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mis Compras App',
              style: GoogleFonts.lato(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold)),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: HomeBody(pageController: _pageController),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: index == 0
            ? FloatingActionButton(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () async {
                  final listName = await showDialog<String>(
                      context: context, builder: (context) => AddListDialog());
                  if (listName != null) {
                    context.read<ShoppingListCubit>().createList(listName);
                  }
                },
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (newIndex) async {
            await _pageController
                .animateToPage(
                  newIndex,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                )
                .then((value) => setState(() => index = newIndex));
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

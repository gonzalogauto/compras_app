import 'package:compras_app/src/presentations/home/cubit/page_cubit.dart';
import 'package:compras_app/src/presentations/home/widgets/home_navigation_bar.dart';
import 'package:compras_app/src/presentations/home/widgets/new_list_button.dart';

import '../widgets/home_body.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, PageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Mis listas app',
              style: GoogleFonts.lora(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: HomeBody(
            pageController: _pageController,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
              state.pageIndex == 0 ? const NewListButton() : null,
          bottomNavigationBar: HomeNavigationBar(
            pageController: _pageController,
            currentPage: state.pageIndex,
          ),
        );
      },
    );
  }
}

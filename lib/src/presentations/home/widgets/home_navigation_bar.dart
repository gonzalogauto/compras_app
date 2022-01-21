import 'package:compras_app/src/presentations/home/cubit/page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({
    Key? key,
    required this.pageController,
    required this.currentPage,
  }) : super(key: key);

  final PageController pageController;

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (newIndex) async {
        await pageController.animateToPage(
          newIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
        );
        context.read<PageCubit>().updatePage(newIndex);
      },
      currentIndex: currentPage,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'Listas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Ajustes',
        ),
      ],
    );
  }
}

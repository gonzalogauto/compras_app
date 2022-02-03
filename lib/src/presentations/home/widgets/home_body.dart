import 'package:flutter/material.dart';

import '../../lists/screen/my_lists.dart';
import '../../settings/screen/settings.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: const [
        MyListPage(),
        SettingsPage(),
      ],
    );
  }
}

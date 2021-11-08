import 'package:compras_app/commons/preferences.dart';
import 'package:compras_app/database/database.dart';
import 'package:compras_app/screens/home.dart';
import 'package:compras_app/screens/list_detail_page.dart';
import 'package:compras_app/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/items_bloc.dart';
import 'bloc/shopping_list_bloc.dart';
import 'cubit/theme_cubit.dart';
import 'screens/my_lists.dart';
import 'singletons/database_singleton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  DatabaseSingleton.database = AppDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => DatabaseSingleton.database.shoppingListDao,
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => ShoppingListBloc()),
          BlocProvider(create: (context) => ItemsBloc())
        ],
        child: BlocBuilder<ThemeCubit, ThemeData>(
          builder: (_, theme) {
            return MaterialApp(
              title: 'Mis Compras App',
              debugShowCheckedModeBanner: false,
              theme: theme,
              onGenerateRoute: (settings) {
                final arguments = settings.arguments as ArgumentData;
                if (settings.name == '/') {
                  return MaterialPageRoute(
                      builder: (context) => const HomeScreen());
                }
                if (settings.name == '/settings') {
                  return MaterialPageRoute(
                      builder: (context) => const SettingsPage());
                }
                if (settings.name == '/detail') {
                  return MaterialPageRoute(
                      builder: (context) => DetailPage(
                            args: arguments,
                          ));
                }
              },
              initialRoute: '/',
              routes: {
                '/': (context) => const HomeScreen(),
                '/settings': (context) => const SettingsPage(),
                DetailPage.routeName: (context) => const DetailPage(),
              },
            );
          },
        ),
      ),
    );
  }
}

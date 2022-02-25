import 'package:compras_app/src/core/commons/argument_data.dart';
import 'package:compras_app/src/core/cubits/theme_cubit.dart';
import 'package:compras_app/src/core/locator.dart';
import 'package:compras_app/src/core/singletons/database_singleton.dart';
import 'package:compras_app/src/presentations/detail/cubit/items_cubit.dart';
import 'package:compras_app/src/presentations/detail/screen/list_detail_page.dart';
import 'package:compras_app/src/presentations/home/cubit/page_cubit.dart';
import 'package:compras_app/src/presentations/home/screens/home.dart';
import 'package:compras_app/src/presentations/lists/cubit/shopping_list_cubit.dart';
import 'package:compras_app/src/presentations/settings/screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpDependencies();
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
          BlocProvider(create: (context) => ShoppingListCubit()),
          BlocProvider(create: (context) => ItemsCubit()),
          BlocProvider(create: (context) => PageCubit())
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (_, theme) {
            final themeData = ThemeData();
            const appColor = Colors.blueGrey;
            return MaterialApp(
              title: 'Mis Compras App',
              debugShowCheckedModeBanner: false,
              theme: themeData.copyWith(
                colorScheme: themeData.colorScheme.copyWith(
                  secondary: appColor,
                  primary: appColor,
                ),
                toggleableActiveColor: appColor,
              ),
              darkTheme: ThemeData.dark(),
              themeMode: theme,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              onGenerateRoute: (settings) {
                final arguments = settings.arguments as ArgumentData?;
                if (settings.name == '/') {
                  return MaterialPageRoute<HomeScreen>(
                    builder: (context) => const HomeScreen(),
                  );
                }
                if (settings.name == '/settings') {
                  return MaterialPageRoute<SettingsPage>(
                    builder: (context) => const SettingsPage(),
                  );
                }
                if (settings.name == '/detail') {
                  return MaterialPageRoute<DetailPage>(
                    builder: (context) => DetailPage(
                      args: arguments,
                    ),
                  );
                }
                return null;
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

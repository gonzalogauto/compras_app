import 'package:compras_app/src/presentations/home/cubit/page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'src/core/commons/argument_data.dart';
import 'src/core/cubits/theme_cubit.dart';
import 'src/core/locator.dart';
import 'src/core/singletons/database_singleton.dart';
import 'src/presentations/detail/cubit/items_cubit.dart';
import 'src/presentations/detail/screen/list_detail_page.dart';
import 'src/presentations/home/screens/home.dart';
import 'src/presentations/lists/cubit/shopping_list_cubit.dart';
import 'src/presentations/settings/screen/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
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
            final ThemeData themeData = ThemeData();
            const appColor = Colors.blueGrey;
            return MaterialApp(
              title: 'Mis Compras App',
              debugShowCheckedModeBanner: false,
              theme: themeData.copyWith(
                  colorScheme: themeData.colorScheme
                      .copyWith(secondary: appColor, primary: appColor),
                  toggleableActiveColor: appColor),
              darkTheme: ThemeData.dark(),
              themeMode: theme,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              onGenerateRoute: (settings) {
                final arguments = settings.arguments as ArgumentData;
                if (settings.name == '/') {
                  return MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  );
                }
                if (settings.name == '/settings') {
                  return MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  );
                }
                if (settings.name == '/detail') {
                  return MaterialPageRoute(
                    builder: (context) => DetailPage(
                      args: arguments,
                    ),
                  );
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

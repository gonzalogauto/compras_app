import 'package:compras_app/src/data/datasource/database/database.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setUpDependencies() async {
  locator
    ..registerLazySingleton<AppDatabase>(
      () => AppDatabase(),
    )
    ..registerSingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance(),
    );
  await locator.allReady();
}

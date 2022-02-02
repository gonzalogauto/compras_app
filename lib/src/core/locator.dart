import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasource/database/database.dart';

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

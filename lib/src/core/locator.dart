import '../data/datasource/database/database.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setUpDependencies() async {
  locator.registerLazySingleton<AppDatabase>(
    () => AppDatabase(),
  );
  locator.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
  await locator.allReady();
}

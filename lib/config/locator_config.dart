import 'package:card_repository/card_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:navigation/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thinkland_task/config/router_config.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<RouterService>(
    RouterService(supportedRoutes: routes),
  );
  locator.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
  locator.registerLazySingleton<CardRepository>(
    () => LocalCardRepository(plugin: locator<SharedPreferences>()),
    dispose: (cardRepository) => cardRepository.close(),
  );
}

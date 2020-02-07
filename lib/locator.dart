import 'package:get_it/get_it.dart';
import './services/navigation_service.dart';
import './services/dialog_service.dart';
import './services/authentication_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
}
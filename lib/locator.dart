import 'package:get_it/get_it.dart';
import './services/navigation_service.dart';
import './services/dialog_service.dart';
import './services/authentication_service.dart';
import './services/firestore_service.dart';
import './services/cloud_storage_service.dart';
import './models/user_model.dart';
import './utils/image_selector.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => ImageSelector());
}

void registerCurrentUser(Map<String, dynamic> data) {
  locator.registerLazySingleton(() => User.fromData(data));
}
import 'package:aldea/ui/views/communities_view.dart';
import 'package:get_it/get_it.dart';
import './services/navigation_service.dart';
import './services/dialog_service.dart';
import './services/authentication_service.dart';
import './services/firestore_service.dart';
import './services/cloud_storage_service.dart';
import './models/user_model.dart';
import './utils/image_selector.dart';
import 'ui/views/profile_view.dart';
import 'ui/views/quickstrike_view.dart';
import 'ui/views/feed_view.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => CommunitiesView());
  locator.registerLazySingleton(() => QuickSTrikeView());
  locator.registerLazySingleton(() => ProfileView());
  locator.registerLazySingleton(() => FeedView());
  
}

void registerCurrentUser(Map<String, dynamic> data) {
  locator.registerLazySingleton(() => User.fromData(data));
}
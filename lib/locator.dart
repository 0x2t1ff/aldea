import 'package:aldea/services/push_notification_service.dart';
import 'package:aldea/services/rtdb_service.dart';
import 'package:aldea/ui/views/communities_view.dart';
import 'package:aldea/ui/views/direct_message_view.dart';
import 'package:aldea/ui/views/login_view.dart';
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
  locator.registerLazySingleton(() => RtdbService());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => CommunitiesView());
  locator.registerLazySingleton(() => QuickSTrikeView());
  locator.registerLazySingleton(() => ProfileView());
  locator.registerLazySingleton(() => FeedView());
  locator.registerLazySingleton(() => DirectMessageView());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => LoginView());
  
}

void registerCurrentUser(Map<String, dynamic> data) {
  locator.registerLazySingleton(() => User.fromData(data));
}
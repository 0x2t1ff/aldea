import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/views/startup_view.dart';
import 'package:flutter/material.dart';
import './services/navigation_service.dart';
import './services/dialog_service.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:flutter/services.dart';
import 'managers/dialog_manager.dart';
import './ui/router.dart';
import 'locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Register all the models and services before the app starts
  setupLocator();
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compound',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 9, 202, 172),
          backgroundColor: Color.fromARGB(255, 26, 27, 30),
          textTheme: TextTheme(
            subtitle1: TextStyle(
                color: almostWhite,
                fontFamily: "Raleway",
                fontWeight: FontWeight.w600,
                fontSize: 12),
          )),
      home: StartUpView(),
      onGenerateRoute: generateRoute,
    );
  }
}

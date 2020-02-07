import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  bool pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, bool isReplaced,
      {dynamic arguments}) {
    return isReplaced
        ? _navigationKey.currentState.pushReplacementNamed(routeName, arguments: arguments)
        : _navigationKey.currentState
            .pushNamed(routeName, arguments: arguments);
  }
}

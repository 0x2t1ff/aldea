import 'package:aldea/ui/views/chats_view.dart';
import 'package:aldea/ui/views/requests_view.dart';
import 'package:aldea/ui/views/vouch_view.dart';

import './views/home_view.dart';
import 'package:flutter/material.dart';
import '../constants/route_names.dart';
import './views/login_view.dart';
import './views/signup_view.dart';
import './views/confirm_number_view.dart';
import 'views/community_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ConfirmPhoneNumberRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ConfirmNumberView(),
      );
    case CommunityViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CommunityView(
          community: settings.arguments,
        ),
      );
    case ChatViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChatsView(
          chatroomId: settings.arguments,
          
        ),
      );
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case RequestsViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: RequestsView(requests: settings.arguments),
      );

    case VouchViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: VouchView(),
      );

    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}

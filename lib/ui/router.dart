import 'package:aldea/ui/views/admin_screen_view.dart';
import 'package:aldea/ui/views/chats_view.dart';
import 'package:aldea/ui/views/comments_view.dart';
import 'package:aldea/ui/views/community_creation_view.dart';
import 'package:aldea/ui/views/community_profile_view.dart';
import 'package:aldea/ui/views/community_users_admin_view.dart';
import 'package:aldea/ui/views/detailed_community_creation_request_view.dart';
import 'package:aldea/ui/views/hero_view.dart';
import 'package:aldea/ui/views/other_profile_view.dart';
import 'package:aldea/ui/views/privacidad_view.dart';
import 'package:aldea/ui/views/requests_view.dart';
import 'package:aldea/ui/views/vouch_view.dart';
import './views/profile_settings_view.dart';
import './views/home_view.dart';
import 'package:flutter/material.dart';
import '../constants/route_names.dart';
import './views/login_view.dart';
import './views/signup_view.dart';
import './views/confirm_number_view.dart';
import 'views/community_view.dart';
import './views/community_settings_view.dart';

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
        viewToShow: RequestsView(
          arguments: settings.arguments,
        ),
      );
    case HeroScreenRoute:
      return _getPageRoute(
          routeName: settings.name, viewToShow: HeroScreen(settings.arguments));

    case VouchViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: VouchView(settings.arguments),
      );

    case OtherProfileViewRoute:
      return _getPageRoute(
          routeName: settings.name,
          viewToShow: OtherProfileView(
            targetUser: settings.arguments,
          ));

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
    case ProfileSettingsViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ProfileSettingsView(settings.arguments),
      );
    case DetailedCommunityCreationViewRoute:
      return _getPageRoute(
          routeName: settings.name,
          viewToShow: DetailedCommunityCreationView(settings.arguments));
    case CommunityCreationViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CommunityCreationView(),
      );
    case AdminScreenViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AdminScreenView(),
      );
    case CommentsViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CommentsView(settings.arguments),
      );
    case CommunityUsersAdminRoute:
      return _getPageRoute(
          routeName: settings.name,
          viewToShow: CommunityUsersAdminView(settings.arguments));
    case PrivacidadViewRoute:
    return _getPageRoute(routeName: settings.name, viewToShow: PrivacidadView());
    case CommunitySettingsViewRoute:
      return _getPageRoute(
          routeName: settings.name,
          viewToShow: CommunitySettingsView(settings.arguments));
    case CommunitiesProfileViewRoute:
      return _getPageRoute(
          routeName: settings.name,
          viewToShow: CommunityProfileView(settings.arguments));
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

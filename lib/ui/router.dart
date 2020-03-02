import 'package:aldea/models/community.dart';
import 'package:aldea/ui/widgets/community_rules.dart';

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
          community: Community(
              name: "PsychoMod",
              bkdPicUrl:
                  "https://scontent-mad1-1.xx.fbcdn.net/v/t1.0-9/31950173_599573057069471_1111610481929355264_n.jpg?_nc_cat=103&_nc_oc=AQlC_y4UZbUQvjft_6Xu4jHJnErkvKQy6lU9q94CjNU61c5Due-ql0IKmPr07LZZ6Ac&_nc_ht=scontent-mad1-1.xx&oh=b02e7633c1d09a4b2bd5807565efdf6d&oe=5EF2257C",
              iconPicUrl:
                  "https://www.kvshop.es/wp-content/uploads/2019/12/cropped-logokvshop.png",
              moderators: ["IucLSVXsb3VyDlG4xgNP1FISURf1"],
              description: "Test"),
        ),
      );
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
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

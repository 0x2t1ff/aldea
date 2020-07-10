import 'package:aldea/locator.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/views/direct_message_view.dart';
import 'package:aldea/ui/views/feed_view.dart';
import 'package:aldea/ui/views/login_view.dart';
import 'package:aldea/ui/views/profile_view.dart';
import 'package:aldea/ui/views/quickstrike_view.dart';
import 'package:aldea/ui/widgets/bottom_filler.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:flutter/material.dart';
import '../views/communities_view.dart';
import '../shared/google_navbar.dart';
import "../shared/ui_helpers.dart" as device;
import "../shared/app_colors.dart" as theme;
import "../../constants/icondata.dart" as custicon;

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CommunitiesView _communitiesView = locator<CommunitiesView>();
  final DirectMessageView _directMessageView = locator<DirectMessageView>();
  final LoginView _loginView = locator<LoginView>();
  final FeedView _feedView = locator<FeedView>();
  final ProfileView _profileView = locator<ProfileView>();
  final QuickSTrikeView _quickSTrikeView = locator<QuickSTrikeView>();
  int selectedIndex = 0;
  PageController controller = PageController();

  List<GButton> tabs = new List();

  var done = false;
  @override
  void initState() {
    super.initState();

    tabs.add(GButton(
      icon: custicon.Home.home,
      // textStyle: t.textStyle,
      text: 'Home         ',
    ));

    tabs.add(GButton(
      icon: custicon.Buscar.buscar,
      // textStyle: t.textStyle,
      text: 'Aldeas         ',
    ));

    tabs.add(GButton(
      icon: custicon.QuickStrike.quickstrike,
      // textStyle: t.textStyle,
      text: 'Quickstrike         ',
    ));

    tabs.add(GButton(
      icon: custicon.Chats.chats,
      // textStyle: t.textStyle,
      text: '     Chats         ',
    ));
    tabs.add(GButton(
      icon: custicon.Profile.profile,
      // textStyle: t.textStyle,
      text: 'Perfil         ',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff0F1013),
      body: Container(
        height: device.screenHeight(context),
        width: double.infinity,
        child: Column(children: <Widget>[
          NotchFiller(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            height: device.usableScreenHeight(context) * 0.1,
            alignment: Alignment.centerLeft,
            color: Color(0xff17191E),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'ALDEA',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Thinoo', fontSize: 40),
                ),
                SizedBox(
                    height: 50, child: Image.asset('assets/images/hoguera.png'))
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: device.usableScreenHeight(context) * 0.8,
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: <Widget>[
                // _feedView,
                _loginView,
                _communitiesView,
                _quickSTrikeView,
                _directMessageView,
                _profileView
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: device.screenWidth(context),
                height: device.usableScreenHeight(context) * 0.1,
                decoration: BoxDecoration(
                  color: theme.blueishGreyColor,
                  boxShadow: [
                    BoxShadow(
                      color: darkGrey.withOpacity(1),
                      spreadRadius: 5,
                      blurRadius: 11,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Container(
                    child: GNav(
                        tabs: tabs,
                        selectedIndex: selectedIndex,
                        onTabChange: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                          controller.jumpToPage(index);
                        }),
                  ),
                ),
              ),
              BottomFiller()
            ],
          )
        ]),
      ),
    );
  }
}

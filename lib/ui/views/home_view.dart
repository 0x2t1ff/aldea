import 'package:aldea/ui/views/profile_view.dart';
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
      backgroundColor: Color(0xff0F1013),
      body: Column(children: <Widget>[
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
              SizedBox(height: 50 ,child: Image.asset('assets/images/hoguera.png'))
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: device.usableScreenHeight(context) * 0.8,
          child: PageView(
            controller: controller,
            children: <Widget>[
              Container(),
              CommunitiesView(),
              Container(),
              Container(),
              ProfileView()
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
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
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
            BottomFiller()
          ],
        )
      ]),
    );
  }
}

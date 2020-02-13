import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
        body: Text('Home'),
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(
            'ALDEA',
            style: TextStyle(color: Colors.black, fontFamily: 'Thinoo'),
          ),
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: SafeArea(
            child: Container(
          width: device.screenWidth(context),
          height: device.screenHeight(context) * 0.092,
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
                  print(index);
                  setState(() {
                    selectedIndex = index;
                  });
                  controller.jumpToPage(index);
                }),
          ),
        )));
  }
}

import 'package:aldea/models/community_creation_request.dart';
import 'package:aldea/models/user_model.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:aldea/viewmodels/detailed_community_creation_view_model.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DetailedCommunityCreationView extends StatelessWidget {
  final CommunityCreationRequest request;

  DetailedCommunityCreationView(this.request, );
  @override
  Widget build(BuildContext context) {
    final TextStyle optionsStyle =
        TextStyle(fontFamily: 'Raleway', fontSize: 14, color: almostWhite);
    final TextStyle titleStyle = TextStyle(
        fontFamily: 'Raleway',
        fontSize: 18,
        color: blueTheme,
        fontWeight: FontWeight.w600);
    return ViewModelBuilder<DetailedCommunityCreationViewModel>.reactive(
      viewModelBuilder: () => DetailedCommunityCreationViewModel(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: darkGrey,
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: screenWidth(context) * 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  NotchFiller(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    height: usableScreenHeight(context) * 0.1,
                    alignment: Alignment.centerLeft,
                    color: Color(0xff17191E),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'ALDEA',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Thinoo',
                              fontSize: 40),
                        ),
                        SizedBox(
                          height: 50,
                          child: Image.asset('assets/images/hoguera.png'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context) * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: screenHeight(context) * 0.02,
                            bottom: screenHeight(context) * 0.02,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                request.name,
                                style: TextStyle(
                                    color: almostWhite,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: 2,
                            width: screenWidth(context) * 0.8,
                            color: almostWhite),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight(context) * 0.026),
                          child: Container(
                            width: screenWidth(context) * 0.8,
                            height: screenHeight(context) * 0.21,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  
                                    image: NetworkImage(request.bkdPicUrl),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: screenHeight(context) * 0.04,
                                  right: screenWidth(context) * 0.275,
                                  child: Container(
                                    width: screenWidth(context) * 0.25,
                                    height: screenWidth(context) * 0.25,
                                    decoration: BoxDecoration(
                                      
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black87,
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(3, 2),
                                        ),
                                      ],
                                      border:
                                          Border.all(width: 5, color: darkGrey),
                                      image: DecorationImage(fit: BoxFit.cover,
                                          image:
                                              NetworkImage(request.iconPicUrl)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(80),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight(context) * 0.025),
                          child: Text(
                            "Descripción",
                            style: titleStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight(context) * 0.01),
                          child: Container(
                              width: screenWidth(context) * 0.8,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: screenHeight(context) * 0.01,
                                    bottom: screenHeight(context) * 0.01),
                                child: Text(request.description,
                                    style: optionsStyle),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight(context) * 0.025),
                          child: Text("Reglas de comunidad", style: titleStyle),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight(context) * 0.01),
                          child: Container(
                            width: screenWidth(context) * 0.8,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.01,
                                  bottom: screenHeight(context) * 0.01),
                              child: Text(request.communityRules,
                                  style: optionsStyle),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight(context) * 0.025),
                          child: Text(
                            "Solicitud",
                            style: titleStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight(context) * 0.01),
                          child: Container(
                              width: screenWidth(context) * 0.8,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: screenHeight(context) * 0.01,
                                    bottom: screenHeight(context) * 0.01),
                                child: Text(
                                  request.messageRequest,
                                  style: optionsStyle,
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: screenHeight(context) * 0.05,
                            bottom: screenHeight(context) * 0.03,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  print("denied");
                                  model.denyRequest(request.id);
                                  model.goBack();
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.clear,
                                    size: 40,
                                    color: darkGrey,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffDF6868),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(300),
                                    ),
                                  ),
                                  width: screenWidth(context) * 0.25,
                                  height: screenHeight(context) * 0.07,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("accepted");
                                  model.acceptRequest(request, request.user.uid);
                                  
                                  model.goBack();
                                },
                                child: Container(
                                  width: screenWidth(context) * 0.25,
                                  height: screenHeight(context) * 0.07,
                                  decoration: BoxDecoration(
                                    color: blueTheme,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(300),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: darkGrey,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

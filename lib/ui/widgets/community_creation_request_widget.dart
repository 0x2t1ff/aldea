import 'package:aldea/models/community_creation_request.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';

import 'package:flutter/material.dart';

class CommunityCreationWidget extends StatelessWidget {
  final CommunityCreationRequest request;
  final Function func;

  CommunityCreationWidget(this.request, this.func);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => func(),
      child: Column(children: <Widget>[
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
                    color: Colors.white, fontFamily: 'Thinoo', fontSize: 40),
              ),
              SizedBox(
                  height: 50, child: Image.asset('assets/images/hoguera.png'))
            ],
          ),
        ),
        Container(
            width: 432,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: darkGrey,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8.0,
                  color: Colors.black.withOpacity(0.5),
                )
              ],
            ),
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(5, 5),
                              blurRadius: 10,
                              color: Colors.black45)
                        ]),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(request.user.picUrl),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(request.user.name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22)),
                          Container(
                            child: Text(
                              request.name,
                              style: TextStyle(
                                  color: blueTheme,
                                  fontSize: 18,
                                  fontFamily: 'Raleway'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Container(
                    child: Text(
                  request.messageRequest,
                  style: TextStyle(fontFamily: 'Raleway', color: almostWhite, fontStyle: FontStyle.italic),
                )),
              ),
              Padding(
                padding:  EdgeInsets.only(top: screenHeight(context) * 0.02),
                child: Container(
                  width: screenWidth(context) * 0.9,
                  height: screenHeight(context) * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(request.bkdPicUrl),
                          fit: BoxFit.none)),
                ),
              )
            ])),
      ]),
    );
  }
}

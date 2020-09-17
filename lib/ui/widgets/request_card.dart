import 'package:aldea/models/community_request.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

// Content for the list items.
class RequestCard extends StatelessWidget {
  final CommunityRequest request;
  final Function acceptFunction;
  final Function denyFunction;

  RequestCard({this.request, this.acceptFunction, this.denyFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenWidth(context),
        height: screenHeight(context) * 0.14,
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              color: Colors.black.withOpacity(0.5),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: screenWidth(context) * 0.02),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      offset: Offset(5, 5),
                      blurRadius: 10,
                      color: Colors.black45)
                ]),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(request.user.picUrl),
                ),
              ),
              Container(
                width: screenWidth(context) * 0.52,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(request.user.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                       Padding(
                         padding:  EdgeInsets.only(top: screenHeight(context) * 0.008),
                         child: Text(
                            request.message,
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                       ),
                      
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth(context) * 0.04),
                child: Container(
                  width: screenWidth(context) * 0.1,
                  height: screenWidth(context) * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: Colors.red),
                  child: IconButton(
                    onPressed: denyFunction,
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth(context) * 0.04),
                child: Container(
                  width: screenWidth(context) * 0.1,
                  height: screenWidth(context) * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: Colors.green),
                  child: IconButton(
                    onPressed: acceptFunction,
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

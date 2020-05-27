import 'package:aldea/models/community_request.dart';
import 'package:flutter/material.dart';
import 'swipe_item.dart';

// Content for the list items.
class RequestCard extends StatelessWidget {
  final CommunityRequest request;
  final Color backgroundColor;

  RequestCard({this.request, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
        width: w + 0.1,
        height: SwipeItem.nominalHeight,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              color: Colors.black.withOpacity(0.5),
            )
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    offset: Offset(5, 5), blurRadius: 10, color: Colors.black45)
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(request.user.name,
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    Expanded(
                      child: Container(
                        child: Text(
                          request.message,
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

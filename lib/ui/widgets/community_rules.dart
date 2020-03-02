import 'package:aldea/models/community.dart';
import 'package:flutter/material.dart';

class CommunityRules extends StatelessWidget {
  final Community community;
  final String uid;

  const CommunityRules({Key key, this.community, this.uid});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          community.moderators.contains(uid)
              ? TextField()
              : Text(community.description)
        ],
      ),
    );
  }
}

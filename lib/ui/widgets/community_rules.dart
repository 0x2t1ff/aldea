import 'package:aldea/models/community.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class CommunityRules extends StatefulWidget {
  final Community community;

  CommunityRules({Key key, this.community});

  @override
  _CommunityRulesState createState() => _CommunityRulesState();
}

class _CommunityRulesState extends State<CommunityRules> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xff17191E),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.community.rules,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                width: double.infinity,
                constraints:
                    BoxConstraints(minHeight: screenHeight(context) * 0.67),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

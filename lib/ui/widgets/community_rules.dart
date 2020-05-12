import 'package:aldea/models/community.dart';
import 'package:flutter/material.dart';

class CommunityRules extends StatefulWidget {
  final Community community;
  final bool isEditting;

  CommunityRules({Key key, this.community, this.isEditting});

  @override
  _CommunityRulesState createState() => _CommunityRulesState();
}

class _CommunityRulesState extends State<CommunityRules> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.community.description;
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          widget.isEditting
              ? TextField(
                  style: TextStyle(color: Colors.white),
                  maxLines: 23,
                  decoration: InputDecoration(
                      hintText: "Escribe una descripcion...",
                      hintStyle: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.white24),
                      filled: true,
                      fillColor: Color(0xff15232B),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      )),
                )
              : Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xff17191E),
                        borderRadius: BorderRadius.circular(15),
                      ),
                  child: Text(widget.community.rules, style: TextStyle(color: Colors.white),),
                  width: double.infinity,
                  constraints: BoxConstraints(minHeight: 200),
                )
        ],
      ),
    );
  }
}

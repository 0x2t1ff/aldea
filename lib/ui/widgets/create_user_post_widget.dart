import 'dart:ui';

import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/viewmodels/user_post_view_model.dart';
import "package:flutter/material.dart";
import "package:aldea/constants/icondata.dart" as custicon;

class CreateUserPosts extends StatefulWidget {
  final UserPostsViewModel model;
  final Function func;
  final String communityId;
  CreateUserPosts({this.model, this.func, this.communityId});

  @override
  _CreateUserPostsState createState() => _CreateUserPostsState();
}

class _CreateUserPostsState extends State<CreateUserPosts> {
  var dropDownvalue;
  var modelDropdown;
  final _textController = TextEditingController();

  final selectedTypeStyle = TextStyle(
    fontSize: 20,
    color: Color(0xff17191E),
    fontWeight: FontWeight.w600,
    fontFamily: "Raleway",
  );
  final unselectedTypeStyle = TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontFamily: "Raleway",
  );
  final selectorStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontFamily: "Raleway",
  );

  List<Widget> postCreation() {
    return [
      Container(
        padding: EdgeInsets.only(bottom: 10),
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Text(
          "Descripcion",
          style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
      Expanded(
        flex: 5,
        child: Container(
          child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff17191E),
                  borderRadius: BorderRadius.circular(20)),
              height: double.infinity,
              width: double.infinity,
              child: TextField(
                controller: _textController,
                textAlignVertical: TextAlignVertical.top,
                expands: true,
                style: TextStyle(color: Colors.white),
                maxLines: null,
                decoration: InputDecoration(
                    hintText: "Escribe una descripcion...",
                    hintStyle: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.white24),
                    filled: true,
                    fillColor: Color(0xff17191E),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    )),
              )),
        ),
      ),
      Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: GestureDetector(
                  onTap: () => widget.model.selectFirstImage(),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xff17191E),
                        borderRadius: BorderRadius.circular(15),
                        image: widget.model.firstImage != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(widget.model.firstImage))
                            : null),
                    child: widget.model.firstImage == null
                        ? Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.white,
                          )
                        : Container(),
                  ),
                )),
                horizontalSpaceMedium,
                Expanded(
                    child: GestureDetector(
                  onTap: () => widget.model.selectSecondImage(),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xff17191E),
                        borderRadius: BorderRadius.circular(15),
                        image: widget.model.secondImage != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(widget.model.secondImage))
                            : null),
                    child: widget.model.secondImage == null
                        ? Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.white,
                          )
                        : Container(),
                  ),
                )),
                horizontalSpaceMedium,
                Expanded(
                    child: GestureDetector(
                  onTap: () => widget.model.selectThirdImage(),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xff17191E),
                        borderRadius: BorderRadius.circular(15),
                        image: widget.model.thirdImage != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(widget.model.thirdImage))
                            : null),
                    child: widget.model.thirdImage == null
                        ? Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.white,
                          )
                        : Container(),
                  ),
                ))
              ],
            ),
          )),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: widget.func,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black45,
                        offset: Offset(5, 5),
                        blurRadius: 4)
                  ]),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: <Widget>[
                  Text("Cancelar",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff17191E),
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w700)),
                  horizontalSpaceSmall,
                  Icon(Icons.clear)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.model
                  .postCreation(widget.communityId, _textController.text);
              widget.func();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black45,
                        offset: Offset(5, 5),
                        blurRadius: 4)
                  ]),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: <Widget>[
                  Text("Listo",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff17191E),
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w700)),
                  horizontalSpaceSmall,
                  Icon(custicon.QuickStrike.quickstrike)
                ],
              ),
            ),
          ),
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      height: usableScreenHeight(context) * 0.8,
      width: screenWidth(context),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF223C47).withOpacity(0.23),
                      borderRadius: BorderRadius.circular(20)),
                  height: usableScreenHeight(context) * 0.9,
                  width: double.infinity,
                ),
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff17191E),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text("Publicacion", style: selectedTypeStyle),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpaceSmall,
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                Expanded(
                  child: Column(children: postCreation()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

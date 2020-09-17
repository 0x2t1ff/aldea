import 'dart:ui';

import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/viewmodels/community_view_model.dart';
import 'package:flutter/material.dart';
import "../../constants/icondata.dart" as custicon;

class CreationPopup extends StatelessWidget {
  final CommunityViewModel model;
  CreationPopup(this.model);

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

  List<Widget> quickstrikeCreation(BuildContext context) {
    return [
      Container(
        padding: EdgeInsets.only(bottom: 10),
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Text(
          "Opciones",
          style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
      Container(
        padding: EdgeInsets.all(20),
        height: usableScreenHeight(context) * 0.25,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff17191E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: usableScreenHeight(context) * 0.035,
              decoration: BoxDecoration(
                color: Color(0xff3C3D42),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(
                        "Cantidad",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff3C3D42),
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w600),
                      ),
                      alignment: Alignment.center,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: model.qsQuantityController,
                        maxLength: 1,
                        maxLengthEnforced: true,
                        style: selectorStyle,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: "",
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.none),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: usableScreenHeight(context) * 0.035,
              decoration: BoxDecoration(
                color: Color(0xff3C3D42),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(
                        "Tipo",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff3C3D42),
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w600),
                      ),
                      alignment: Alignment.center,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: DropdownButton(
                        value: model.dropDownValue,
                        dropdownColor: Color(0xff3C3D42),
                        isDense: true,
                        underline: Container(),
                        elevation: 8,
                        items: [
                          DropdownMenuItem(
                            onTap: () {
                              model.quickStrikePost.isQuestion = false;
                              model.quickStrikePost.isGame = false;
                              model.quickStrikePost.isRandom = true;
                            },
                            value: "Random",
                            child: Text("Random", style: selectorStyle),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              model.quickStrikePost.isQuestion = false;
                              model.quickStrikePost.isGame = true;
                              model.quickStrikePost.isRandom = false;
                            },
                            value: "Boton",
                            child: Text(
                              "Boton",
                              style: selectorStyle,
                            ),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              model.quickStrikePost.isQuestion = true;
                              model.quickStrikePost.isGame = false;
                              model.quickStrikePost.isRandom = false;
                            },
                            value: "Pregunta",
                            child: Text(
                              "Pregunta",
                              style: selectorStyle,
                            ),
                          )
                        ],
                        onChanged: (val) {
                          model.setDropdownValue(val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: usableScreenHeight(context) * 0.035,
              decoration: BoxDecoration(
                color: Color(0xff3C3D42),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(
                        "Modelo",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff3C3D42),
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w600),
                      ),
                      alignment: Alignment.center,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: DropdownButton(
                        style: selectorStyle,
                        value: model.modelDropdown,
                        dropdownColor: Color(0xff3C3D42),
                        isDense: true,
                        underline: Container(),
                        elevation: 8,
                        items: model
                            .getProductNames()
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (val) {
                          model.setModelDropdown(val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: usableScreenHeight(context) * 0.035,
              decoration: BoxDecoration(
                color: Color(0xff3C3D42),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(
                        "Hora",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff3C3D42),
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w600),
                      ),
                      alignment: Alignment.center,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => model.selectDate(context),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xff3C3D42),
                        ),
                        alignment: Alignment.center,
                        child: model.selectedDate != null
                            ? Text(
                                "${model.selectedDate.day}-${model.selectedDate.month}-${model.selectedDate.year} ${model.selectedDate.hour}:${model.selectedDate.minute}",
                                style: selectorStyle,
                              )
                            : Container(),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10),
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
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff17191E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: double.infinity,
                        width: double.infinity,
                        child: TextField(
                          controller: model.qsDescController,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(color: Colors.white),
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Escribe una descripcion...",
                            hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white24),
                            filled: true,
                            fillColor: Color(0xff17191E),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    horizontalSpaceSmall,
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () => model.selectFirstImage(),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xff17191E),
                                    borderRadius: BorderRadius.circular(15),
                                    image: model.firstImage != null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(model.firstImage),
                                          )
                                        : null),
                                child: model.firstImage == null
                                    ? Icon(
                                        Icons.add,
                                        size: 40,
                                        color: Colors.white,
                                      )
                                    : Container(),
                                width: double.infinity,
                              ),
                            ),
                          ),
                          verticalSpaceSmall,
                          Expanded(
                            child: GestureDetector(
                              onTap: () => model.selectSecondImage(),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xff17191E),
                                    borderRadius: BorderRadius.circular(15),
                                    image: model.secondImage != null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(model.secondImage),
                                          )
                                        : null),
                                child: model.secondImage == null
                                    ? Icon(
                                        Icons.add,
                                        size: 40,
                                        color: Colors.white,
                                      )
                                    : Container(),
                                width: double.infinity,
                              ),
                            ),
                          ),
                          verticalSpaceSmall,
                          Expanded(
                            child: GestureDetector(
                              onTap: () => model.selectThirdImage(),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xff17191E),
                                    borderRadius: BorderRadius.circular(15),
                                    image: model.thirdImage != null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(model.thirdImage),
                                          )
                                        : null),
                                child: model.thirdImage == null
                                    ? Icon(
                                        Icons.add,
                                        size: 40,
                                        color: Colors.white,
                                      )
                                    : Container(),
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Text(
          "Cuestionario",
          style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
      Container(
        padding: EdgeInsets.all(20),
        height: usableScreenHeight(context) * 0.25,
        width: double.infinity,
        child: Column(
          children: [],
        ),
      )
    ];
  }

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
                controller: model.postDescController,
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
                onTap: () => model.selectFirstImage(),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff17191E),
                      borderRadius: BorderRadius.circular(15),
                      image: model.firstImage != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(model.firstImage))
                          : null),
                  child: model.firstImage == null
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
                onTap: () => model.selectSecondImage(),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff17191E),
                      borderRadius: BorderRadius.circular(15),
                      image: model.secondImage != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(model.secondImage))
                          : null),
                  child: model.secondImage == null
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
                onTap: () => model.selectThirdImage(),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff17191E),
                      borderRadius: BorderRadius.circular(15),
                      image: model.thirdImage != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(model.thirdImage))
                          : null),
                  child: model.thirdImage == null
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
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      height: usableScreenHeight(context) * 0.9,
      width: double.infinity,
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
                        child: GestureDetector(
                          onTap: () {
                            model.setIsQuickstrike(true);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Quickstrike",
                                style: model.isQuickstrike
                                    ? selectedTypeStyle
                                    : unselectedTypeStyle,
                              ),
                              decoration: BoxDecoration(
                                color: model.isQuickstrike
                                    ? Colors.white
                                    : Color(0xff17191E),
                                borderRadius: BorderRadius.circular(50),
                              )),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            model.setIsQuickstrike(false);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: !model.isQuickstrike
                                  ? Colors.white
                                  : Color(0xff17191E),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Publicar",
                              style: model.isQuickstrike
                                  ? unselectedTypeStyle
                                  : selectedTypeStyle,
                            ),
                            padding: EdgeInsets.all(8),
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
                Container(
                  height: screenHeight(context) * 0.5,
                  child: SingleChildScrollView(
                    child: Container(
                      height: 600,
                      width: 500,
                      child: Column(
                        children: model.isQuickstrike
                            ? quickstrikeCreation(context)
                            : postCreation(),
                      ),
                    ),
                  ),
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => model.cancelChanges(),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
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
                      onTap: () => model.isQuickstrike
                          ? model.uploadQuickStrike()
                          : model.uploadPost(),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: model.isUploading
                            ? CircularProgressIndicator()
                            : Row(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

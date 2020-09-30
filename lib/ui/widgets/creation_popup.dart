import 'dart:ui';
import 'package:aldea/ui/shared/app_colors.dart';
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
  final containerStyle =
      TextStyle(fontFamily: "Raleway", color: almostBlack, fontSize: 17);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 6.0,
            sigmaY: 6.0,
          ),
          child: Container(
            color: Colors.white.withOpacity(0.2),
            height: screenHeight(context) * 0.7,
            width: screenWidth(context) * 0.9,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight(context) * 0.02,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: screenHeight(context) * 0.09,
                        width: screenWidth(context),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: screenWidth(context) * 0.7,
                              height: screenHeight(context) * 0.06,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Container(
                                width: screenWidth(context) * 0.6,
                                height: screenHeight(context) * 0.1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        model.setIsQuickstrike(true);
                                      },
                                      child: Container(
                                          height: screenHeight(context) * 0.06,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 9),
                                          child: Text(
                                            "Quickstrike",
                                            style: model.isQuickstrike
                                                ? selectedTypeStyle
                                                : unselectedTypeStyle,
                                          ),
                                          decoration: BoxDecoration(
                                            color: model.isQuickstrike
                                                ? Colors.white
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        model.setIsQuickstrike(false);
                                      },
                                      child: Container(
                                        height: screenHeight(context) * 0.06,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: !model.isQuickstrike
                                              ? Colors.white
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          "Publicar",
                                          style: model.isQuickstrike
                                              ? unselectedTypeStyle
                                              : selectedTypeStyle,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal:
                                                screenWidth(context) * 0.05),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: double.infinity,
                                  height: 3,
                                  color: almostWhite),
                            ),
                          ],
                        ),
                      ),
                    ),
                    model.isQuickstrike
                        ? quickstrikeWidget(context)
                        : postWidget(context)
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget postWidget(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Descripción",
          style: unselectedTypeStyle,
        ),
        Padding(
          padding: EdgeInsets.only(top: screenHeight(context) * 0.02),
          child: Container(
              width: screenWidth(context) * 0.7,
              height: screenHeight(context) * 0.3,
              decoration: BoxDecoration(
                  color: Color(0xff17191E),
                  borderRadius: BorderRadius.circular(20)),
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
        Padding(
          padding: EdgeInsets.only(top: screenHeight(context) * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => model.selectFirstImage(),
                child: Container(
                  width: screenWidth(context) * 0.21,
                  height: screenHeight(context) * 0.11,
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
              ),
              GestureDetector(
                onTap: () => model.selectSecondImage(),
                child: Container(
                  width: screenWidth(context) * 0.21,
                  height: screenHeight(context) * 0.11,
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
              ),
              GestureDetector(
                onTap: () => model.selectThirdImage(),
                child: Container(
                  width: screenWidth(context) * 0.21,
                  height: screenHeight(context) * 0.11,
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
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: screenHeight(context) * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                onTap: () => model.isUploading ? () {} : model.uploadPost(),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                            Icon(custicon.Publicaciones.publicaciones)
                          ],
                        ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
//
//
//
//
//
//
//
//
//
//  The body of the quickstrike
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

  Widget quickstrikeWidget(BuildContext context) {
    return Container(
      width: screenWidth(context),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight(context) * 0.015),
            child: Text(
              "Opciones",
              style: unselectedTypeStyle,
            ),
          ),
          Container(
            width: screenWidth(context),
            height: screenHeight(context) * 0.23,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context) * 0.04,
                  vertical: screenHeight(context) * 0.02),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: screenHeight(context) * 0.04,
                    decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: screenWidth(context) * 0.25,
                          height: screenHeight(context) * 0.04,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Text(
                            "Cantidad",
                            style: containerStyle,
                          ),
                        ),
                        Expanded(
                          child: Container(
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
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight(context) * 0.01),
                    child: Container(
                      width: double.infinity,
                      height: screenHeight(context) * 0.04,
                      decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: screenWidth(context) * 0.25,
                            height: screenHeight(context) * 0.04,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Text(
                              "Tipo",
                              style: containerStyle,
                            ),
                          ),
                          Expanded(
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
                                      model.isQuestion = false;
                                      model.isGame = false;
                                      model.isRandom = true;
                                    },
                                    value: "Random",
                                    child: Text("Random", style: selectorStyle),
                                  ),
                                  DropdownMenuItem(
                                    onTap: () {
                                      model.isQuestion = false;
                                      model.isGame = true;
                                      model.isRandom = false;
                                    },
                                    value: "Boton",
                                    child: Text(
                                      "Boton",
                                      style: selectorStyle,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    onTap: () {
                                      model.isQuestion = true;
                                      model.isGame = false;
                                      model.isRandom = false;
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight(context) * 0.01),
                    child: Container(
                      width: double.infinity,
                      height: screenHeight(context) * 0.04,
                      decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: screenWidth(context) * 0.25,
                            height: screenHeight(context) * 0.04,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Text(
                              "Modelo",
                              style: containerStyle,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: TextField(
                                controller: model.qsModelController,
                                style: selectorStyle,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  counterText: "",
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight(context) * 0.01),
                    child: Container(
                      width: double.infinity,
                      height: screenHeight(context) * 0.04,
                      decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: screenWidth(context) * 0.25,
                            height: screenHeight(context) * 0.04,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Text(
                              "Hora",
                              style: containerStyle,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => model.selectDate(context),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //
//
//
//
//
//
//
//
//
//
//2do bloque del widget
//
//
//
//
//
//
//
//
//
//
//
//
          model.isQuestion
              ? Padding(
                  padding: EdgeInsets.only(top: screenHeight(context) * 0.04),
                  child: Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.02),
                              child: Text(
                                "Pregunta",
                                style: unselectedTypeStyle,
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                top: screenHeight(context) * 0.02),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              alignment: Alignment.center,
                              width: screenWidth(context) * 0.55,
                              height: screenHeight(context) * 0.05,
                              child: TextField(
                                controller: model.qsQuestionController,
                                style: selectorStyle,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "Formula la pregunta",
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight(context) * 0.02),
                                    child: Text(
                                      "Respuestas",
                                      style: unselectedTypeStyle,
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: screenHeight(context) * 0.02),
                                  child: Container(
                                    width: screenWidth(context) * 0.1,
                                    alignment: Alignment.center,
                                    child: DropdownButton(
                                      value: model.questionNumber,
                                      dropdownColor: Color(0xff3C3D42),
                                      isDense: true,
                                      underline: Container(),
                                      elevation: 8,
                                      items: [
                                        DropdownMenuItem(
                                          onTap: () {
                                            model.changeNumberQuestions(1);
                                          },
                                          value: 2,
                                          child:
                                              Text("2", style: selectorStyle),
                                        ),
                                        DropdownMenuItem(
                                          onTap: () {
                                            model.changeNumberQuestions(2);
                                          },
                                          value: 3,
                                          child: Text(
                                            "3",
                                            style: selectorStyle,
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          onTap: () {
                                            model.changeNumberQuestions(3);
                                          },
                                          value: 4,
                                          child: Text(
                                            "4",
                                            style: selectorStyle,
                                          ),
                                        )
                                      ],
                                      onChanged: (val) {
                                        model.changeNumberQuestions(val);
                                      },
                                    ),
                                  ),
                                ),
                              ]),
                          Padding(
                            padding: EdgeInsets.only(
                                top: screenHeight(context) * 0.02),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              alignment: Alignment.center,
                              width: screenWidth(context) * 0.55,
                              height: screenHeight(context) * 0.05,
                              child: TextField(
                                controller: model.qsCorrectAnswerController,
                                style: selectorStyle,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "Respuesta correcta",
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: screenHeight(context) * 0.02,
                                bottom: screenHeight(context) * 0.02),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              alignment: Alignment.center,
                              width: screenWidth(context) * 0.55,
                              height: screenHeight(context) * 0.05,
                              child: TextField(
                                controller: model.qsFirstWrongAnserController,
                                style: selectorStyle,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "Respuesta incorrecta",
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          model.questionNumber >= 3
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight(context) * 0.02),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    alignment: Alignment.center,
                                    width: screenWidth(context) * 0.55,
                                    height: screenHeight(context) * 0.05,
                                    child: TextField(
                                      controller:
                                          model.qsSecondWrongAnserController,
                                      style: selectorStyle,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "Respuesta incorrecta",
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          model.questionNumber >= 4
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight(context) * 0.02),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    alignment: Alignment.center,
                                    width: screenWidth(context) * 0.55,
                                    height: screenHeight(context) * 0.05,
                                    child: TextField(
                                      controller:
                                          model.qsThirdWrongAnserController,
                                      style: selectorStyle,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "Respuesta incorrecta",
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      )),
                )
              : Container(),
          //
          //
          // 3er bloque del widget
//
//
//
//
//
//
//
//
//
//
//
//
          Padding(
            padding: EdgeInsets.only(top: screenHeight(context) * 0.01),
            child: Container(
                height: screenHeight(context) * 0.35,
                width: screenWidth(context),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Descripción", style: unselectedTypeStyle)),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight(context) * 0.02,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenWidth(context) * 0.5,
                            height: screenHeight(context) * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: backgroundColor,
                            ),
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
                          Container(
                            height: screenHeight(context) * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => model.selectFirstImage(),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xff17191E),
                                        borderRadius: BorderRadius.circular(15),
                                        image: model.firstImage != null
                                            ? DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    FileImage(model.firstImage),
                                              )
                                            : null),
                                    child: model.firstImage == null
                                        ? Icon(
                                            Icons.add,
                                            size: 40,
                                            color: Colors.white,
                                          )
                                        : Container(),
                                    width: screenWidth(context) * 0.18,
                                    height: screenHeight(context) * 0.06,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => model.selectSecondImage(),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xff17191E),
                                        borderRadius: BorderRadius.circular(15),
                                        image: model.secondImage != null
                                            ? DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(
                                                    model.secondImage),
                                              )
                                            : null),
                                    child: model.secondImage == null
                                        ? Icon(
                                            Icons.add,
                                            size: 40,
                                            color: Colors.white,
                                          )
                                        : Container(),
                                    width: screenWidth(context) * 0.18,
                                    height: screenHeight(context) * 0.06,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => model.selectThirdImage(),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xff17191E),
                                        borderRadius: BorderRadius.circular(15),
                                        image: model.thirdImage != null
                                            ? DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    FileImage(model.thirdImage),
                                              )
                                            : null),
                                    child: model.thirdImage == null
                                        ? Icon(
                                            Icons.add,
                                            size: 40,
                                            color: Colors.white,
                                          )
                                        : Container(),
                                    width: screenWidth(context) * 0.18,
                                    height: screenHeight(context) * 0.06,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: screenHeight(context) * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
                            onTap: () => model.isUploading
                                ? () {}
                                : model.uploadQuickStrike(),
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
                      ),
                    )
                  ],
                )),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

import 'dart:math';

import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/quickstrike_item.dart';
import 'package:aldea/viewmodels/quickstrike_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import "../shared/app_colors.dart" as custcolor;

class QuickSTrikeView extends StatelessWidget {
  final QuickStrikePost emptyQuickstrike = new QuickStrikePost(
    isEmpty: true,
  );
  @override
  Widget build(BuildContext context) {
    bool quickstrikeActive = true;
    double buttonWidth = getRandomWidth();
    double buttonHeight = getRandomHeight();
    return ViewModelBuilder<QuickStrikeViewModel>.reactive(
        viewModelBuilder: () => QuickStrikeViewModel(),
        onModelReady: (model) => model.fetchPosts(),
        createNewModelOnInsert: true,
        builder: (context, model, child) => Scaffold(
            body: !model.busy
                ? Container(
                    child: Stack(children: <Widget>[
                      StreamBuilder(
                        stream: model.posts,
                        builder: (context, data) {
                          if (data.hasData == false) {
                            return Text(
                              'No Data...',
                            );
                          } else if (data.hasError) {
                            return Text(data.error.toString());
                          } else if (data.data == null) {
                            return Center(child: Text("data is null"));
                          } else {
                            List dataList = data.data;
                            List<DocumentSnapshot> documentList = [];
                            List<QuickStrikePost> quickstrikepostList = [];
                            //Primer foreach para filtrar el stream , ya que pasa un valor que no es un documentsnapshot dentro de la lista
                            dataList.forEach((element) {
                              if (element.runtimeType == DocumentSnapshot) {
                                documentList.add(element);
                              }
                            });
                            documentList.forEach((element) {
                              DocumentSnapshot docSnapshot = element;
                              Map<dynamic, dynamic> quickstrikeMap =
                                  docSnapshot.data;
                              quickstrikepostList
                                  .add(QuickStrikePost.fromMap(quickstrikeMap));
                            });
                            return quickstrikepostList.length > 8
                                ? ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemCount: quickstrikepostList.length,
                                    itemBuilder: (context, index) {
                                      if (quickstrikepostList[index].isActive) {
                                        quickstrikeActive = true;
                                      }
                                      return QuickStrikeItem(
                                          model: model,
                                          quickStrikePost:
                                              quickstrikepostList[index],
                                          index: index);
                                    })
                                : ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemCount: 8,
                                    itemBuilder: (context, index) =>
                                        quickstrikepostList.length > index
                                            ? QuickStrikeItem(
                                                model: model,
                                                quickStrikePost:
                                                    quickstrikepostList[index],
                                                index: index)
                                            : QuickStrikeItem(
                                                index: index,
                                                quickStrikePost:
                                                    emptyQuickstrike,
                                                model: model,
                                              ));
                          }
                        },
                      ),
                      quickstrikeActive
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * buttonHeight,
                                  left: screenWidth(context) * buttonWidth),
                              child: Container(
                                width: screenWidth(context) * 0.2,
                                height: screenWidth(context) * 0.2,
                                child: GestureDetector(
                                  onTap: () {
                                    buttonWidth = getRandomWidth();
                                    buttonHeight = getRandomHeight();
                                  },
                                  child: Container(
                                      child: Image.asset(
                                          "assets/images/boton_quickstrike.png"),
                                      width: screenWidth(context) * 0.2,
                                      height: screenWidth(context) * 0.2),
                                ),
                              ),
                            )
                          : Container(
                              width: 0,
                              height: 0,
                            ),
                    ]),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(custcolor.blueishGreyColor),
                    ),
                  )));
  }

  double getRandomWidth() {
    final _random = new Random();
    double randomNumber = _random.nextDouble();
    randomNumber = randomNumber * 0.8;
    return randomNumber.toDouble();
  }

  double getRandomHeight() {
    final _random = new Random();
    double randomNumber = _random.nextDouble();
    randomNumber = randomNumber * 0.66;
    return randomNumber.toDouble();
  }
}

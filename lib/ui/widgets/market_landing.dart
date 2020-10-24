import 'dart:math';

import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/market_categories.dart';
import 'package:aldea/viewmodels/market_view_model.dart';
import 'package:flutter/material.dart';

import 'market_item.dart';

class MarketLanding extends StatelessWidget {
  final MarketViewModel model;

  const MarketLanding({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: false
      //por si algun dia hay q tocar el codigo antiguo lo lo borro but like...XD
          ? Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: communityBodyHeight(context) * 0.025),
                  width: double.infinity,
                  height: communityBodyHeight(context) * 0.28,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: model.busy
                            ? CircularProgressIndicator()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    model.firstCategory,
                                    style: TextStyle(
                                        color: Color(0xffb5b5b5),
                                        fontSize: 29,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(Icons.star, color: Color(0xff3C8FA7))
                                ],
                              ),
                      ),
                      Container(
                          child: model.busy
                              ? CircularProgressIndicator()
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                      Flexible(
                                        child: MarketItem(
                                          product: model.firstProducts[0],
                                          model: model,
                                        ),
                                      ),
                                      horizontalSpaceSmall,
                                      Flexible(
                                        child: MarketItem(
                                          product: model.firstProducts[1],
                                          model: model,
                                        ),
                                      ),
                                      horizontalSpaceSmall,
                                      Flexible(
                                        child: MarketItem(
                                          product: model.firstProducts[2],
                                          model: model,
                                        ),
                                      )
                                    ]))
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: communityBodyHeight(context) * 0.5,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: communityBodyHeight(context) * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Novedades",
                                  style: TextStyle(
                                      color: Color(0xffb5b5b5),
                                      fontSize: 29,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.star, color: Color(0xff3C8FA7))
                              ],
                            ),
                            GestureDetector(
                              onTap: () => model.showMore(),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xff223C47),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Más",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(width: 5),
                                    Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(pi),
                                      child: Icon(
                                        Icons.reply,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      !model.busy
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      communityBodyHeight(context) * 0.025),
                              height: communityBodyHeight(context) * 0.44,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 4,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: GestureDetector(
                                            onTap: () => model.selectProduct(
                                                model.newestProducts[0]),
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  color: Color(0xff223C47),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(5, 5),
                                                        color: Colors.black45)
                                                  ],
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          "${model.newestProducts[0].imagesList[0]}"))),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black45,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(14),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    14))),
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 5),
                                                child: Text(
                                                  "${model.newestProducts[0].name} - ${model.newestProducts[0].price.toString()}€",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        horizontalSpaceSmall,
                                        Expanded(
                                          flex: 2,
                                          child: GestureDetector(
                                            onTap: () => model.selectProduct(
                                                model.newestProducts[1]),
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  color: Color(0xff223C47),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(4, 4),
                                                        color: Colors.black45)
                                                  ],
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          "${model.newestProducts[1].imagesList[0]}"))),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black45,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(14),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    14))),
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 5),
                                                child: Text(
                                                  "${model.newestProducts[1].name} - ${model.newestProducts[1].price.toString()}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  verticalSpaceMedium,
                                  Expanded(
                                      flex: 3,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            flex: 1,
                                            child: MarketItem(
                                              product: model.newestProducts[2],
                                              model: model,
                                            ),
                                          ),
                                          horizontalSpaceSmall,
                                          Flexible(
                                            child: MarketItem(
                                              product: model.newestProducts[3],
                                              model: model,
                                            ),
                                          ),
                                          horizontalSpaceSmall,
                                          Flexible(
                                            child: MarketItem(
                                              product: model.newestProducts[4],
                                              model: model,
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            )
                          : CircularProgressIndicator()
                    ],
                  ),
                ),
              ],
            )
          : MarketCategories(model: model),
    );
  }
}

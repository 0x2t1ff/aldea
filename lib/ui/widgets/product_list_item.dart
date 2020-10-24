import "package:flutter/material.dart";
import 'package:aldea/ui/shared/app_colors.dart';
import "../shared/ui_helpers.dart";
import 'package:aldea/viewmodels/market_view_model.dart';

class ProductListItem extends StatelessWidget {
  final MarketViewModel model;
  final int index;
  ProductListItem(this.model, this.index);
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        fontFamily: 'Raleway',
        color: almostWhite,
        fontWeight: FontWeight.w600,
        fontSize: screenWidth(context) * 0.035);
    TextStyle priceStyle = TextStyle(
        fontFamily: 'Raleway',
        color: almostWhite,
        fontWeight: FontWeight.w600,
        fontSize: screenWidth(context) * 0.045);
    return Container(
        color: index % 2 == 0 ? backgroundColor : darkGrey,
        width: screenWidth(context),
        height: screenHeight(context) * 0.1,
        child: Row(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.05),
              child: CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage(model.cartProducts[index].imagesList[0]),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: screenHeight(context) * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    model.cartProducts[index].name,
                    style: textStyle,
                  ),
                  Text(model.cartProducts[index].model, style: textStyle),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth(context) * 0.1),
              child: Text(
                model.cartProducts[index].price.toString() + " €",
                style: priceStyle,
              ),
            ),
            GestureDetector(
                child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth(context) * 0.15),
                child: GestureDetector(
                    onTap: () => model.removeFromCart(index),
                    child:
                        Icon(Icons.remove_circle, color: Colors.red, size: 30)),
              ),
            ))
          ],
        ));
  }
}

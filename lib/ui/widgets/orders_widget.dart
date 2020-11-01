import 'package:aldea/viewmodels/market_view_model.dart';
import "../shared/ui_helpers.dart";
import 'package:flutter/material.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/models/order.dart';
import '../../constants/languages.dart';

class OrderWidget extends StatelessWidget {
  final String communityId;
  final int index;
  final Order order;
  final Function openUser;
  final Function openDetailedProduct;
  OrderWidget(this.index, this.order, this.openUser, this.openDetailedProduct, this.communityId);

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
        color: almostWhite,
        fontFamily: "Raleway",
        fontWeight: FontWeight.bold,
        fontSize: 15);
    return GestureDetector(
      onTap: () => openDetailedProduct(),
      child: Container(
          height: screenHeight(context) * 0.11,
          width: screenWidth(context),
          color: index % 2 == 0 ? backgroundColor : darkGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(order.creationDate.toDate().toString().substring(0, 10),
                  style: titleStyle),
              Text(order.totalPrice.toString() + "€", style: titleStyle),
              Text("Products ${order.products.length}", style: titleStyle)
            ],
          )),
    );
  }
}

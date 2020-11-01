import 'package:aldea/viewmodels/market_view_model.dart';
import "../shared/ui_helpers.dart";
import 'package:flutter/material.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/widgets/orders_widget.dart';
import 'package:aldea/models/order.dart';

class NewOrdersView extends StatelessWidget {
  final MarketViewModel model;
  NewOrdersView(this.model);

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    model.loadOrders();
    return Container(
      height: screenHeight(context) * 0.64,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: model.newOrders.length,
          itemBuilder: (context, index) {
            Order currentOrder = Order.fromData(
                model.newOrders[index].data, model.newOrders[index].documentID);
            return OrderWidget(
                index, currentOrder, () => print(" nothing for now sorry kekw"),
                () {
              List list = [currentOrder, model.uid];
              model.openDetailedOrder(list);
            }, model.uid);
          }),
    );
  }
}

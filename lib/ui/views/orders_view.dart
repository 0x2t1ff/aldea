import 'package:aldea/viewmodels/market_view_model.dart';
import "../shared/ui_helpers.dart";
import 'package:flutter/material.dart';
import 'package:aldea/ui/widgets/product_list_item.dart';
import 'package:aldea/ui/views/new_orders_view.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import '../../constants/languages.dart';

class OrdersView extends StatefulWidget {
  final MarketViewModel model;
  OrdersView(this.model);

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> with TickerProviderStateMixin {
  TabController _controller;
  bool get wantKeepAlive => true;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller = TabController(vsync: this, length: 2, initialIndex: 0);
    TextStyle checkStyle = TextStyle(
        color: almostWhite,
        fontFamily: "Raleway",
        fontWeight: FontWeight.bold,
        fontSize: 14);
    return Container(
        height: screenHeight(context) * 0.7,
        child: Column(
          children: [
            TabBar(
              controller: _controller,
              tabs: [
                Container(
                    alignment: Alignment.center,
                    height: screenHeight(context) * 0.05,
                    width: screenWidth(context) * 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text("Nuevos pedidos", style: checkStyle),
                    )),
                Container(
                    alignment: Alignment.center,
                    height: screenHeight(context) * 0.05,
                    width: screenWidth(context) * 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Text("Realizados", style: checkStyle),
                    )),
              ],
            ),
            Container(
              height: screenHeight(context) * 0.64,
              child: TabBarView(
                controller: _controller,
                children: [
                  NewOrdersView(widget.model),
                  Container()
                ],
              ),
            )
          ],
        ));
  }
}

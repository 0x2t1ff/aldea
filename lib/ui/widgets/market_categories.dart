import 'package:aldea/models/product.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/viewmodels/market_view_model.dart';
import 'package:flutter/material.dart';

import 'market_item.dart';

class MarketCategories extends StatelessWidget {
  final MarketViewModel model;

  Widget buildProductRows(List<Product> list) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Flexible(
          child: MarketItem(
            product: list[0],
            model: model,
          ),
        ),
        horizontalSpaceSmall,
        Flexible(
          child: list.length > 1
              ? MarketItem(
                  product: list[1],
                  model: model,
                )
              : Container(),
        ),
        horizontalSpaceSmall,
        Flexible(
          child: list.length > 2
              ? MarketItem(
                  product: list[2],
                  model: model,
                )
              : Container(),
        )
      ]),
    );
  }

  Widget buildCategorySet(String name, List<Product> products) {
    int rowNumber = (products.length / 3).ceil();
    List<Widget> list = [];
    for (var i = 1; i <= rowNumber; i++) {
      if (i == 1) {
        list.add(buildProductRows(products));
      } else if (products.length >= i * 3) {
        list.add(buildProductRows(products.skip((i * 3) - 1).toList()));
      } else if (products.length == (i * 3) - 1) {
        list.add(buildProductRows(products.skip((i * 3) - 2).toList()));
      } else if (products.length == (i * 3) - 2) {
        list.add(buildProductRows(products.skip((i * 3) - 3).toList()));
      }
    }

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
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
            child: Column(
          children: list,
        ))
      ],
    );
  }

  const MarketCategories({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    model.products
      ..forEach((key, value) => list.add(buildCategorySet(key, value)));
    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }
}

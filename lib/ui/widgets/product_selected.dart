import 'package:aldea/models/product.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/product_carousel.dart';
import 'package:aldea/viewmodels/market_view_model.dart';
import 'package:flutter/material.dart';

class ProductSelected extends StatelessWidget {
  final Product product;
  final MarketViewModel model;

  const ProductSelected({Key key, this.product, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: communityBodyHeight(context) * 0.84,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    Text(
                      product.name,
                      style: TextStyle(
                          color: Color(0xffB1AFAF),
                          fontSize: 32,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold),
                    ),
                    horizontalSpaceTiny,
                    Icon(
                      Icons.star,
                      color: Color(0xff549BAF),
                      size: 32,
                    )
                  ]),
                  IconButton(
                      icon: Icon(Icons.reply, color: Colors.white, size: 32,),
                      onPressed: () => model.unselectProduct())
                ],
              ),
            ),
          ),
          ProductCarousel(product.imagesList),
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          product.model,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () => model.addProductToCart(product),
                          child: SizedBox(
                              height: 32,
                              child:
                                  Image.asset("assets/images/add-to-cart.png")),
                        )
                      ],
                    ),
                    Text(
                      "${product.price.toString()}€",
                      style: TextStyle(
                          color: Color(0xff549BAF),
                          fontSize: 26,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w600),
                    ),
                    verticalSpaceSmall,
                    Expanded(
                      child: Text(
                        "${product.description}",
                        style: TextStyle(
                          color: Color(0xffE4E4E4),
                          fontSize: 19,
                          fontFamily: "Raleway",
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

import 'package:aldea/models/product.dart';
import 'package:aldea/viewmodels/market_view_model.dart';
import 'package:flutter/material.dart';

class MarketItem extends StatelessWidget {
  final Product product;
  final MarketViewModel model;

  const MarketItem({Key key, this.product, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => model.selectProduct(product),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Color(0xff223C47),
              boxShadow: [
                BoxShadow(offset: Offset(5, 5), color: Colors.black45)
              ],
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.imagesList[0]))),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14))),
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      "${product.name} - ${product.price.toString()}€",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(
                    child: Image.asset(
                  "assets/images/white-cart.png",
                  height: 16,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

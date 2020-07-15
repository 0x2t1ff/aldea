import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/cart_view.dart';
import 'package:aldea/ui/widgets/bottom_filler.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:aldea/viewmodels/market_view_model.dart';
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  final MarketViewModel model;

  CartView(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: communityBodyHeight(context) * 0.84,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, i) => Container(
                height: screenHeight(context) * 0.12,
                width: screenWidth(context),
                decoration: BoxDecoration(color: Color(0xff17191E), boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 4),
                      color: Colors.black38,
                      blurRadius: 4),
                ]),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: screenHeight(context) * 0.08,
                      width: screenHeight(context) * 0.08,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  model.cart.keys.toList()[i].imagesList[0]),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            model.cart.keys.toList()[i].name,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Raleway",
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Modelo: ",
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontFamily: "Raleway",
                                    fontSize: 14),
                              ),
                              Text(
                                model.cart.keys.toList()[i].model,
                                style: TextStyle(
                                    color: Color(0xff3C8FA7),
                                    fontFamily: "Raleway",
                                    fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: Color(0xff223C47),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              "${(model.cart.keys.toList()[i].price * model.cart.values.toList()[i]).toStringAsFixed(2)}€",
                              style: TextStyle(
                                  fontFamily: "Raleway",
                                  color: Color(0xff549BAF),
                                  fontSize: 20),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => model.removeProductToCart(
                                      model.cart.keys.toList()[i]),
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Color(0xffE4E4E4),
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  model.cart.values.toList()[i].toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Raleway",
                                      fontSize: 20),
                                ),
                                GestureDetector(
                                  onTap: () => model.addProductToCart(
                                      model.cart.keys.toList()[i]),
                                  child: Icon(
                                    Icons.add_circle,
                                    color: Color(0xffE4E4E4),
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              itemCount: model.cart.length,
              padding: EdgeInsets.only(top: 20),
            ),
          ),
          Container(
            height: screenHeight(context) * 0.08,
            width: double.infinity,
            color: Color(0xff17191E),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => model.backFromCartView(),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Total ",
                        style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xff3CA759),
                            borderRadius: BorderRadius.circular(25)),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          model.getTotalPrice().toStringAsFixed(2) + "€",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Raleway",
                              fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          BottomFiller(),
        ],
      ),
    );
  }
}

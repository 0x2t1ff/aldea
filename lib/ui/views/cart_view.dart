import 'package:aldea/viewmodels/market_view_model.dart';
import "../shared/ui_helpers.dart";
import 'package:flutter/material.dart';
import 'package:aldea/ui/widgets/product_list_item.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import '../../constants/languages.dart';

class CartView extends StatelessWidget {
  final MarketViewModel model;
  CartView(this.model);

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    TextStyle checkStyle = TextStyle(
        color: almostBlack,
        fontFamily: "Raleway",
        fontWeight: FontWeight.bold,
        fontSize: 15);
    return Container(
        height: screenHeight(context) * 0.7,
        child: Column(
          children: [
            Container(
                height: screenHeight(context) * 0.62,
                child: model.cartProducts.isEmpty
                    ? Center(
                        child: Text(
                            languages[model.currentLanguage]["empty cart"],
                            style: TextStyle(color: Colors.white)))
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: model.cartProducts.length,
                        itemBuilder: (context, index) =>
                            ProductListItem(model, index))),
            Expanded(
              child: Container(
                  color: almostBlack,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: screenHeight(context) * 0.05,
                        width: screenWidth(context) * 0.35,
                        decoration: BoxDecoration(
                            color: blueTheme,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "TOTAL ${model.cartPrice.toString()} €",
                          style: checkStyle,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (model.cartProducts.isNotEmpty &&
                              !model.isSubmitting) {
                            model.checkout();
                          }
                        },
                        child: Container(
                            height: screenHeight(context) * 0.05,
                            width: screenWidth(context) * 0.28,
                            decoration: BoxDecoration(
                                color: blueTheme,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(languages[model.currentLanguage]["order"],
                                    style: checkStyle),
                                model.isSubmitting
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  almostBlack),
                                        ),
                                      )
                                    : Icon(Icons.check_outlined)
                              ],
                            )),
                      )
                    ],
                  )),
            )
          ],
        ));
  }
}

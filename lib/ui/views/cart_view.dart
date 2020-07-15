import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/bottom_filler.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:aldea/viewmodels/market_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CartView extends StatelessWidget {
  final MarketViewModel model;

  const CartView({this.model});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MarketViewModel>.nonReactive(
      viewModelBuilder: () => model,
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color(0xff0F1013),
        body: Column(
          children: <Widget>[
            NotchFiller(),
            Container(
              height: screenHeight(context) * 0.08,
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xff17191E), boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4), color: Colors.black, blurRadius: 5)
              ]),
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text(
                "Productos",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Raleway"),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, i) => Container(
                  height: screenHeight(context) * 0.12,
                  width: double.infinity,
                  color: Color(0xff17191E),
                  padding: const EdgeInsets.all(12),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: screenHeight(context) * 0.12 - 24,
                        width: screenHeight(context) * 0.12 - 24,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                      )
                    ],
                  ),
                ),
                itemCount: model.cart.length,
                padding: EdgeInsets.all(0),
              ),
            ),
            Container(
              height: screenHeight(context) * 0.08,
              width: double.infinity,
              color: Color(0xff17191E),
              padding: const EdgeInsets.all(8),
            ),
            BottomFiller(),
          ],
        ),
      ),
    );
  }
}

import 'package:aldea/viewmodels/detailed_order_view_model.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import "../shared/app_colors.dart";
import 'package:aldea/models/order.dart';
import "../shared/ui_helpers.dart";
import 'package:aldea/ui/widgets/notch_filler.dart';
import '../../constants/languages.dart';

class DetailedOrderView extends StatelessWidget {
  final List list;
  final bool isOld;
  DetailedOrderView({this.list, this.isOld});
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        color: almostWhite,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.bold,
        fontSize: 18);
    return ViewModelBuilder<DetailedOrderViewModel>.reactive(
      viewModelBuilder: () => DetailedOrderViewModel(),
      onModelReady: (model) async {
        model.setLoading(true);
        model.list = list;
        await model.setData();
        model.setLoading(false);
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  NotchFiller(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    height: screenHeight(context) * 0.1,
                    alignment: Alignment.centerLeft,
                    color: Color(0xff17191E),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'ALDEA',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Thinoo',
                              fontSize: 40),
                        ),
                        SizedBox(
                          height: 50,
                          child: Image.asset('assets/images/hoguera.png'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: screenHeight(context) * 0.75,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: model.order.products.length,
                        itemBuilder: (context, index) {
                          return Container(
                              color:
                                  index % 2 == 0 ? darkGrey : backgroundColor,
                              height: screenHeight(context) * 0.1,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(model.order.products[index]["model"],
                                      style: textStyle),
                                  Text(
                                      model.order.products[index]["price"]
                                              .toString() +
                                          "€",
                                      style: textStyle)
                                ],
                              ));
                        }),
                  ),
                  Expanded(
                    child: Container(
                        color: blueTheme,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(model.user.address, style: textStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (!isOld)
                                  GestureDetector(
                                      onTap: () => model.dismissOrder(),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                screenWidth(context) * 0.02),
                                            child: Text(
                                                languages[model.currentLanguage]
                                                    ["dismiss order"],
                                                style: textStyle),
                                          ))),
                                GestureDetector(
                                    onTap: () => model.goToUser(),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: almostWhite,
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              screenWidth(context) * 0.02),
                                          child: Row(
                                            children: [
                                              Text(languages[model
                                                  .currentLanguage]["profile"]),
                                              Icon(Icons.person)
                                            ],
                                          ),
                                        )))
                              ],
                            )
                          ],
                        )),
                  )
                ],
              ),
      ),
    );
  }
}

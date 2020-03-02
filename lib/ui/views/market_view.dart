import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/viewmodels/market_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class MarketView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<MarketViewModel>.withConsumer(
        viewModel: MarketViewModel(),
        builder: (context, model, child) => Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: communityBodyHeight(context) * 0.1,
                    padding: EdgeInsets.symmetric(
                        vertical: communityBodyHeight(context) * 0.025),
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              hintText: "Buscar",
                              hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white24),
                              filled: true,
                              fillColor: Color(0xff15232B),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              )),
                        )),
                        horizontalSpaceMedium,
                        SizedBox(
                          height: communityBodyHeight(context) * 0.045,
                          child: Image.asset("assets/images/white-cart.png"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: communityBodyHeight(context) * 0.3,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Tapas",
                              style: TextStyle(
                                  color: Color(0xffb5b5b5),
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.star, color: Color(0xff3C8FA7))
                          ],
                        ),
                        Expanded(
                            child: GridView.count(
                          crossAxisCount: 3,
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                          crossAxisSpacing: 20,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(4, 4),
                                        color: Colors.black)
                                  ]),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14))),
                            Container(
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Color(0xff223C47),
                                  image: null),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff223C47).withOpacity(0.6),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(14),
                                        bottomRight: Radius.circular(14))),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  "PRODUCTO - PRECIO",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}

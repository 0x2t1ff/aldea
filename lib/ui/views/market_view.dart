import 'package:aldea/models/community.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/market_landing.dart';
import 'package:aldea/ui/widgets/product_selected.dart';
import 'package:aldea/viewmodels/market_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MarketView extends StatefulWidget {
  final Community community;

  const MarketView(this.community);

  @override
  _MarketViewState createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> with AutomaticKeepAliveClientMixin {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MarketViewModel>.reactive(
        viewModelBuilder: () => MarketViewModel(widget.community.uid),
        
        onModelReady: (m) async {
          await m.fetchProducts();
          m.setFirstProducts();
        },
        builder: (context, model, child) => Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: communityBodyHeight(context) * 0.08,
                    padding: EdgeInsets.only(
                        top: communityBodyHeight(context) * 0.025, left: 15, right: 15),
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

                  model.isProductSelected ? ProductSelected(product: model.selectedProduct, model: model,
                  ) :
                  MarketLanding(model: model) ,
                ],
              ),
            ));
  }
}

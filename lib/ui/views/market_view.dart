import 'package:aldea/models/community.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/cart_view.dart';
import 'package:aldea/ui/widgets/market_landing.dart';
import 'package:aldea/ui/widgets/product_selected.dart';
import 'package:aldea/viewmodels/market_view_model.dart';
import '../../models/product.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MarketView extends StatefulWidget {
  final Community community;
  final Map<String, List<Product>> products;

  MarketView(this.community, this.products);

  @override
  _MarketViewState createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MarketViewModel>.reactive(
        viewModelBuilder: () =>
            MarketViewModel(widget.community.uid, widget.products),
        onModelReady: (m) {
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
                        top: communityBodyHeight(context) * 0.025,
                        left: 15,
                        right: 15),
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
                        GestureDetector(
                          onTap: () => model.navigateToCartView(),
                          child: SizedBox(
                            height: communityBodyHeight(context) * 0.045,
                            child: Stack(
                              overflow: Overflow.visible,
                              alignment: Alignment.bottomRight,
                              children: <Widget>[
                                Image.asset("assets/images/white-cart.png"),
                                if (model.cart.length > 0)
                                  Positioned(
                                    bottom: -5,
                                    right: -5,
                                    child: Container(
                                      child: FittedBox(
                                          child: Text(
                                        model.totalItems.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )),
                                      height:
                                          communityBodyHeight(context) * 0.025,
                                      width:
                                          communityBodyHeight(context) * 0.025,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  model.isShowingCart
                      ? CartView(model)
                      : model.isProductSelected
                          ? ProductSelected(
                              product: model.selectedProduct,
                              model: model,
                            )
                          : MarketLanding(model: model),
                ],
              ),
            ));
  }
}

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
      builder: (context, model, child) => Scaffold(),
    );
  }
}

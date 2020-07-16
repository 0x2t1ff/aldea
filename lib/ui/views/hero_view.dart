import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/HeroCarousel.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:aldea/ui/widgets/posts_carousel.dart';
import 'package:aldea/viewmodels/hero_view_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HeroScreen extends StatelessWidget {
  final List url;
  const HeroScreen(this.url);
  @override
  Widget build(BuildContext context) {
    String tag = "Hero";
    return ViewModelBuilder<HeroViewModel>.reactive(
      viewModelBuilder: () => HeroViewModel(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NotchFiller(),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight(context) * 0.01,
                  left: screenWidth(context) * 0.01),
              child: GestureDetector(
                child: Icon(
                  Icons.clear,
                  size: screenWidth(context) * 0.1,
                  color: blueTheme,
                ),
                onTap: () => model.popScreen(),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: screenWidth(context),
                  maxHeight: screenHeight(context) * 0.875),
              child: GestureDetector(
                child: Center(
                  child: Hero(
                    tag: tag,
                    child: HeroCarousel(
                      imageUrl: url,
                    ),
                  ),
                ),
                onTap: () => model.popScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

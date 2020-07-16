import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import "../shared/ui_helpers.dart";

class HeroCarousel extends StatefulWidget {
  final List imageUrl;
  const HeroCarousel({this.imageUrl});
  @override
  _HeroCarouselState createState() => _HeroCarouselState();
}

int _current = 0;
Widget countPointer(int index) {
  return Container(
    width: 10.0,
    height: 10.0,
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: _current == index
          ? Colors.white.withOpacity(0.8)
          : Colors.grey.withOpacity(0.8),
    ),
  );
}

class _HeroCarouselState extends State<HeroCarousel> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      CarouselSlider.builder(
        height: screenHeight(context) * 0.875,
        itemCount: widget.imageUrl.length,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
        itemBuilder: (BuildContext context, int itemIndex) => Container(
          width: screenWidth(context),
          height: screenHeight(context) * 0.875,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.imageUrl[itemIndex]),
                  fit: BoxFit.contain)),
        ),
      ),
      Positioned(
        bottom: screenHeight(context) * 0,
        left: 0.0,
        right: 0.0,
        child: widget.imageUrl.length == 1
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    ...widget.imageUrl
                        .map((image) =>
                            countPointer(widget.imageUrl.indexOf(image)))
                        .toList()
                  ]),
      )
    ]);
  }
}

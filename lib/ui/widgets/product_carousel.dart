import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductCarousel extends StatefulWidget {
  final List urls;

  ProductCarousel(this.urls);

  @override
  _ProductCarouselState createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
  Widget imgContainer(String url) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
    );
  }

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

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: Offset(5, 5), color: Colors.black54, blurRadius: 3)
          ]),
          child: CarouselSlider(
            viewportFraction: 1.0,
            aspectRatio: 4 / 3,
            items: widget.urls.map((url) {
              return imgContainer(url);
            }).toList(),
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
      ),
      Positioned(
        top: communityBodyHeight(context) * 0.3,
        left: 0.0,
        right: 0.0,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ...widget.urls
                  .map((url) => countPointer(widget.urls.indexOf(url)))
                  .toList()
            ]),
      )
    ]);
  }
}

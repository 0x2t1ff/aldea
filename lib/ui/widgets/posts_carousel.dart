import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import "../shared/ui_helpers.dart" as devicesize;

class PostCarousel extends StatefulWidget {
  final List imageUrl;
  const PostCarousel({this.imageUrl});
  @override
  _PostCarouselState createState() => _PostCarouselState();
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

class _PostCarouselState extends State<PostCarousel> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      CarouselSlider.builder(
        itemCount: widget.imageUrl.length,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        aspectRatio: 4 / 3,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
        height: devicesize.screenHeight(context) * 0.4,
        itemBuilder: (BuildContext context, int itemIndex) => Container(
          width: devicesize.screenWidth(context),
          height: devicesize.screenHeight(context) * 0.4,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.imageUrl[itemIndex]),
                  fit: BoxFit.cover)),
        ),
      ),
      Positioned(
        top: devicesize.screenHeight(context) * 0.31,
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

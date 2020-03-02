import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CommunitiesCarousel extends StatefulWidget {
  final bool busy;
  final String url1;
  final String url2;
  final String url3;

  CommunitiesCarousel({this.busy, this.url1, this.url2, this.url3});

  @override
  _CommunitiesCarouselState createState() => _CommunitiesCarouselState();
}

class _CommunitiesCarouselState extends State<CommunitiesCarousel> {
  Widget imgContainer(String url) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
    );
  }

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff3C8FA7),
          borderRadius: BorderRadius.circular(14),
        ),
        child: widget.busy
            ? Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ))
            : ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CarouselSlider(
                  viewportFraction: 1.0,
                  items: [
                    imgContainer(widget.url1),
                    imgContainer(widget.url2),
                    imgContainer(widget.url3),
                  ],
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 500),
                  autoPlayInterval: Duration(seconds: 5),
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
      ),
      Positioned(
        bottom: 25,
        left: 0.0,
        right: 0.0,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
            width: 10.0,
            height: 10.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == 0
                  ? Colors.white.withOpacity(0.8)
                  : Colors.grey.withOpacity(0.8),
            ),
          ),
          Container(
            width: 10.0,
            height: 10.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == 1
                 ? Colors.white.withOpacity(0.8)
                  : Colors.grey.withOpacity(0.8),
            ),
          ),
          Container(
            width: 10.0,
            height: 10.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == 2
                  ? Colors.white.withOpacity(0.8)
                  : Colors.grey.withOpacity(0.8),
            ),
          )
        ]),
      )
    ]);
  }
}

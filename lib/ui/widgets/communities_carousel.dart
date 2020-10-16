import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/viewmodels/communities_view_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CommunitiesCarousel extends StatefulWidget {
  final bool busy;
  final List<Map<String, dynamic>> urls;
  final CommunitiesViewModel model;

  CommunitiesCarousel({this.busy, this.urls, this.model});

  @override
  _CommunitiesCarouselState createState() => _CommunitiesCarouselState();
}

class _CommunitiesCarouselState extends State<CommunitiesCarousel> {
  Widget imgContainer(Map<String, dynamic> map) {
    return GestureDetector(
      onTap: () async {
        await widget.model.getTopCommunity(map["uid"]).then(
              (value) => widget.model.selectCommunity(value),
            );
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(map["picUrl"]), fit: BoxFit.cover)),
      ),
    );
  }

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 20, bottom: 10),
        width: screenWidth(context) * 0.85,
        decoration: BoxDecoration(
          color: Colors.transparent,
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
                  items: widget.urls.length == 0
                      ? []
                      : [...widget.urls.map((e) => imgContainer(e)).toList()],
                  autoPlay: widget.urls.length > 1,
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
        top: screenHeight(context) * 0.24,
        left: 0.0,
        right: 0.0,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.urls == null
                ? []
                : [
                    ...widget.urls
                        .map(
                          (e) => Container(
                            width: 10.0,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == 0
                                  ? Colors.white.withOpacity(0.8)
                                  : Colors.grey.withOpacity(0.8),
                            ),
                          ),
                        )
                        .toList(),
                  ]),
      )
    ]);
  }
}

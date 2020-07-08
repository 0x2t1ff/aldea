import 'package:aldea/ui/widgets/feed_widget.dart';
import 'package:aldea/viewmodels/feed_view_model.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';
import "../shared/app_colors.dart" as custcolor;
import "../shared/ui_helpers.dart" as devicesize;

class FeedView extends StatefulWidget {
  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  static final _containerHeight = 100.0 / 800;

  // You don't need to change any of these variables
  var _fromTop = -_containerHeight;
  var _controller = ScrollController();
  var _allowReverse = true, _allowForward = true;
  var _prevOffset = 0.0;
  var _prevForwardOffset = -_containerHeight;
  var _prevReverseOffset = 0.0;

  @override
  void initState() {
    super.initState();

    _controller.addListener(_listener);
  }

  void _listener() {
    double offset = _controller.offset / 800;

    var direction = _controller.position.userScrollDirection;

    if (direction == ScrollDirection.reverse) {
      _allowForward = true;
      if (_allowReverse) {
        _allowReverse = false;
        _prevOffset = offset;
        _prevForwardOffset = _fromTop;
      }

      var difference = offset - _prevOffset;
      _fromTop = _prevForwardOffset + difference;
      if (_fromTop > 0) _fromTop = 0;
    } else if (direction == ScrollDirection.forward) {
      _allowReverse = true;
      if (_allowForward) {
        _allowForward = false;
        _prevOffset = offset;
        _prevReverseOffset = _fromTop;
      }

      var difference = offset - _prevOffset;
      _fromTop = _prevReverseOffset + difference;
      if (_fromTop < -_containerHeight) _fromTop = -_containerHeight;
    }
    setState(() {
      print(_fromTop);
    }); // for simplicity I'm calling setState here, you can put bool values to only call setState when there is a genuine change in _fromTop
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
      viewModelBuilder: () => FeedViewModel(),
      onModelReady: (model) => model.fetchPosts(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: custcolor.darkGrey,
        body: Stack(
          children: <Widget>[
            model.posts != null
                ? ListView.builder(
                    controller: _controller,
                    padding: EdgeInsets.all(0),
                    itemCount: model.posts.length,
                    itemBuilder: (context, index) => index == 0
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: devicesize.screenHeight(context) * 0.125),
                            child: FeedWidget(
                                navigateToComments: () =>
                                    model.goToComments(model.posts[index].id),
                                postModel: model.posts[index],
                                likeFunction: () => model.likePost(
                                    model.posts[index].id,
                                    model.isLiked(model.posts[index].likes),
                                    model.posts[index].likes),
                                isLiked:
                                    model.isLiked(model.posts[index].likes)),
                          )
                        : FeedWidget(
                            navigateToComments: () =>
                                model.goToComments(model.posts[index].id),
                            postModel: model.posts[index],
                            likeFunction: () => model.likePost(
                                model.posts[index].id,
                                model.isLiked(model.posts[index].likes),
                                model.posts[index].likes),
                            isLiked: model.isLiked(model.posts[index].likes)),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(custcolor.blueishGreyColor),
                    ),
                  ),
            model.communityList != null
                ? Positioned(
                    top: devicesize.screenHeight(context) * (-0.125 - _fromTop),
                    child: Container(
                      color: custcolor.darkGrey,
                      width: devicesize.screenWidth(context),
                      height:
                          devicesize.screenHeight(context) * _containerHeight,
                      child: Align(
                        child: Container(
                          height: devicesize.screenHeight(context) * 0.085,
                          child: model.communityList.length < 7
                              ? ListView.builder(
                                  padding: EdgeInsets.only(
                                      left: devicesize.screenWidth(context) *
                                          0.02),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return index < model.communityList.length
                                        ? GestureDetector(
                                            onTap: () => model.goToCommunity(
                                                model.communityList[index]),
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        devicesize.screenWidth(
                                                                context) *
                                                            0.018),
                                                height: devicesize
                                                        .screenHeight(context) *
                                                    0.055,
                                                child: ClipOval(
                                                  child: Image.network(
                                                    model.communityList[index]
                                                        .iconPicUrl,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )))
                                        : Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: custcolor.blueishGreyColor,
                                            ),
                                            width: devicesize
                                                    .screenHeight(context) *
                                                0.097,
                                          );
                                  })
                              : ListView.builder(
                                  padding: EdgeInsets.only(
                                      left: devicesize.screenWidth(context) *
                                          0.02),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: model.communityList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () => model.goToCommunity(
                                            model.communityList[index]),
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: devicesize
                                                        .screenWidth(context) *
                                                    0.018),
                                            height: devicesize
                                                    .screenHeight(context) *
                                                0.055,
                                            child: ClipOval(
                                              child: Image.network(
                                                model.communityList[index]
                                                    .iconPicUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            )));
                                  }),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

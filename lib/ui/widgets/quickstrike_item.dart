
import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/ui/shared/shared_styles.dart';
import 'package:aldea/viewmodels/quickstrike_view_model.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../shared/ui_helpers.dart' as devicesize;
import '../shared/app_colors.dart' as custcolor;

class QuickStrikeItem extends StatefulWidget {
  final QuickStrikeViewModel model;
  final QuickStrikePost quickStrikePost;
  final int index;
  final bool isParticipating;
  final Function heroFunction;
  const QuickStrikeItem(
      {Key key,
      this.heroFunction,
      this.quickStrikePost,
      this.index,
      this.model,
      this.isParticipating})
      : super(key: key);

  @override
  _QuickStrikeItemState createState() => _QuickStrikeItemState();
}

class _QuickStrikeItemState extends State<QuickStrikeItem> {
  bool isEnlisted = false;
  bool isExpanded = false;
  String animationSelector = "";
  @override
  void initState() {
    isEnlisted = widget.isParticipating;
    if (widget.isParticipating) {
      animationSelector = "GREEN";
    } else {
      animationSelector = "RED";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var quickstrikeType = "";
    int estimateTs = widget.quickStrikePost.isEmpty
        ? null
        : widget.quickStrikePost.fechaQuickstrike.millisecondsSinceEpoch;

    if (widget.quickStrikePost.isEmpty) {
    } else if (widget.quickStrikePost.isGame) {
      quickstrikeType = "Game";
    }
    if (widget.quickStrikePost.isEmpty) {
    } else if (widget.quickStrikePost.isRandom) {
      quickstrikeType = "Random";
    }
    if (widget.quickStrikePost.isEmpty) {
    } else if (widget.quickStrikePost.isQuestion) {
      quickstrikeType = "Pregunta";
    }
    return widget.quickStrikePost.isEmpty
        ? Container(
            decoration: BoxDecoration(
              color: widget.index % 2 == 0
                  ? custcolor.darkGrey
                  : custcolor.backgroundColor,
              boxShadow: [
                BoxShadow(
                    color: isExpanded ? Colors.red : Colors.black,
                    blurRadius: 4.0,
                    spreadRadius: 0,
                    offset: Offset(
                      0,
                      0,
                    )),
              ],
            ),
            width: devicesize.screenWidth(context),
            height: devicesize.screenHeight(context) * 0.103,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: devicesize.screenWidth(context) * 0.045),
                ),
              ],
            ),
          )
        : Column(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 4.0,
                      spreadRadius: 0,
                      offset: Offset(
                        0,
                        0,
                      )),
                ],
                color: widget.index % 2 == 0
                    ? custcolor.darkGrey
                    : custcolor.backgroundColor,
              ),
              width: devicesize.screenWidth(context),
              height: devicesize.screenHeight(context) * 0.103,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: devicesize.screenWidth(context) * 0.045),
                  ),
                  Container(
                    decoration: quickstrikePicDecoration,
                    child: CircleAvatar(
                      radius: devicesize.screenWidth(context) * 0.055,
                      backgroundImage:
                          NetworkImage(widget.quickStrikePost.imageUrl[0]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: devicesize.screenWidth(context) * 0.045),
                  ),
                  //Foto de la comunidad , placeholder

                  Container(
                    width: devicesize.screenWidth(context) * 0.436,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: devicesize.screenHeight(context) * 0.017),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: devicesize.screenHeight(context) * 0.008),
                          child: Text(
                            widget.quickStrikePost.communityName,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontSize:
                                  devicesize.screenHeight(context) * 0.017,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: devicesize.screenHeight(context) * 0.005),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Tipo quickstrike: ",
                                style: TextStyle(
                                  color: Color(0xff8E8E8E),
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      devicesize.screenHeight(context) * 0.014,
                                ),
                              ),
                              Text(
                                quickstrikeType,
                                style: TextStyle(
                                    color: Color(0xff3C8FA7),
                                    fontSize: devicesize.screenHeight(context) *
                                        0.014,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Modelo: ",
                              style: TextStyle(
                                color: Color(0xff8E8E8E),
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    devicesize.screenHeight(context) * 0.014,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.quickStrikePost.modelo,
                                style: TextStyle(
                                    color: Color(0xff3C8FA7),
                                    fontSize: devicesize.screenHeight(context) *
                                        0.014,
                                    fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: devicesize.screenWidth(context) * 0.24,
                        height: devicesize.screenHeight(context) * 0.06,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: custcolor.darkGrey,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  2.0,
                                  4.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(100),
                            color: isEnlisted
                                ? Colors.green
                                : custcolor.lightBlueColor),
                        // set needed date

                        child: Padding(
                          padding: EdgeInsets.only(
                              top: devicesize.screenHeight(context) * 0.017),
                          child: StreamBuilder(
                              stream: Stream.periodic(
                                  Duration(seconds: 1), (i) => i),
                              builder: (BuildContext context,
                                  AsyncSnapshot<int> snapshot) {
                                DateFormat format = DateFormat("mm:ss");
                                int now = DateTime.now().millisecondsSinceEpoch;
                                Duration remaining =
                                    Duration(milliseconds: estimateTs - now);
                                var dateString =
                                    '${remaining.inHours}:${format.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}';
                                return Text(
                                  dateString, //dateString,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: isEnlisted
                                          ? Colors.white
                                          : Color(0xff3C8FA7),
                                      fontFamily: 'Raleway',
                                      fontSize:
                                          devicesize.screenWidth(context) *
                                              0.04,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: devicesize.screenHeight(context) * 0.05),
                          child: GestureDetector(
                            child: Icon(
                              Icons.expand_more,
                              size: 25,
                              color: Colors.white,
                            ),
                            onTap: () => setState(() {
                              isExpanded = !isExpanded;
                            }),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            isExpanded
                ? Container(
                    decoration: BoxDecoration(
                      color: widget.index % 2 == 0
                          ? custcolor.backgroundColor
                          : custcolor.darkGrey,
                    ),
                    padding: EdgeInsets.only(
                        bottom: devicesize.screenHeight(context) * 0.0185),
                    width: devicesize.screenWidth(context),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  devicesize.screenWidth(context) * 0.05),
                          width: devicesize.screenWidth(context),
                          color: widget.index % 2 == 0
                              ? custcolor.backgroundColor
                              : custcolor.darkGrey,
                          padding: EdgeInsets.only(
                            top: devicesize.screenHeight(context) * 0.02,
                          ),
                          child: Text(
                            widget.quickStrikePost.description,
                            style: TextStyle(
                                fontSize:
                                    devicesize.screenWidth(context) * 0.03,
                                color: Color(0xff3C8FA7),
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: devicesize.screenHeight(context) * 0.016,
                              bottom: devicesize.screenHeight(context) * 0.01),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: devicesize.screenWidth(context) * 0.04,
                                  bottom:
                                      devicesize.screenHeight(context) * 0.01),
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: devicesize.screenHeight(context) *
                                            0.1),
                                    child: widget.quickStrikePost.imageUrl
                                                .length ==
                                            3
                                        ? Container(
                                            height: devicesize
                                                    .screenHeight(context) *
                                                0.0775,
                                            width: devicesize
                                                    .screenHeight(context) *
                                                0.0775,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      devicesize.screenWidth(
                                                              context) *
                                                          0.03),
                                            ),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        devicesize.screenWidth(
                                                                context) *
                                                            0.03),
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      widget.heroFunction(),
                                                  child: Hero(
                                                    tag: 'imageHero',
                                                    child: Image.network(
                                                      widget.quickStrikePost
                                                          .imageUrl[2],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )),
                                          )
                                        : Container(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: devicesize.screenHeight(context) *
                                            0.05),
                                    child: widget.quickStrikePost.imageUrl
                                                .length >=
                                            2
                                        ? Container(
                                            height: devicesize
                                                    .screenHeight(context) *
                                                0.0775,
                                            width: devicesize
                                                    .screenHeight(context) *
                                                0.0775,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(1,
                                                      0), // changes position of shadow
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      devicesize.screenWidth(
                                                              context) *
                                                          0.03),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      devicesize.screenWidth(
                                                              context) *
                                                          0.03),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    widget.heroFunction(),
                                                child: Image.network(
                                                  widget.quickStrikePost
                                                      .imageUrl[1],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ),
                                  widget.quickStrikePost.imageUrl.length > 0
                                      ? Container(
                                          height:
                                              devicesize.screenHeight(context) *
                                                  0.0775,
                                          width:
                                              devicesize.screenHeight(context) *
                                                  0.0775,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(1,
                                                    0), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(
                                                devicesize
                                                        .screenWidth(context) *
                                                    0.03),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                devicesize
                                                        .screenWidth(context) *
                                                    0.03),
                                            child: GestureDetector(
                                              onTap: () =>
                                                  widget.heroFunction(),
                                              child: Image.network(
                                                widget.quickStrikePost
                                                    .imageUrl[0],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: devicesize.screenWidth(context) * 0.39,
                                  right:
                                      devicesize.screenHeight(context) * 0.01),
                              child: GestureDetector(
                                //TODO: metodo de participacion con el servicio de firebase y aviso de compra en caso de ser ganador
                                onTap: () {
                                  isEnlisted
                                      ? widget.model.quitQuickstrike(
                                          widget.quickStrikePost)
                                      : widget.model.joinQuickstrike(
                                          widget.quickStrikePost);
                                  isEnlisted = !isEnlisted;
                                  if (isEnlisted) {
                                    animationSelector = 'RTOG';
                                    Future.delayed(Duration(milliseconds: 400),
                                        () {
                                      animationSelector = "GREEN";
                                    });
                                  } else {
                                    animationSelector = 'GTOR';
                                    Future.delayed(Duration(milliseconds: 400),
                                        () {
                                      animationSelector = "RED";
                                    });
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  height:
                                      devicesize.screenHeight(context) * 0.0678,
                                  width:
                                      devicesize.screenWidth(context) * 0.1921,
                                  child: FlareActor(
                                    'assets/animations/quickstrikeAnimation.flr',
                                    fit: BoxFit.cover,
                                    animation: animationSelector,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container()
          ]);
  }
}

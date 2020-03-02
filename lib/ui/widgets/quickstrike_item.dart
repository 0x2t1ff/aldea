import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/ui/shared/shared_styles.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../shared/ui_helpers.dart' as devicesize;
import '../shared/app_colors.dart' as custcolor;

class QuickStrikeItem extends StatefulWidget {
  final QuickStrikePost quickStrikePost;
  const QuickStrikeItem({Key key, this.quickStrikePost}) : super(key: key);

  @override
  _QuickStrikeItemState createState() => _QuickStrikeItemState();
}

class _QuickStrikeItemState extends State<QuickStrikeItem> {
  bool isExpanded = true;
  bool isEnlisted = false;
  String animationSelector = "";
  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
    var quickstrikeType = "";
    int estimateTs = widget.quickStrikePost.fechaQuickstrike.millisecondsSinceEpoch;

    if (widget.quickStrikePost.isGame) {
      quickstrikeType = "Game";
    }
    if (widget.quickStrikePost.isGame) {
      quickstrikeType = "Random";
    }
    if (widget.quickStrikePost.isLista) {
      quickstrikeType = "Lista";
    }
    return Column(children: <Widget>[
      Container(
        width: devicesize.screenWidth(context),
        height: devicesize.screenHeight(context) * 0.103,
        color: custcolor.darkGrey,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: devicesize.screenWidth(context) * 0.045),
            ),
            Container(
              decoration: quickstrikePicDecoration,
              child: CircleAvatar(
                radius: devicesize.screenWidth(context) * 0.065,
                backgroundImage: NetworkImage(widget.quickStrikePost.imageUrl),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: devicesize.screenWidth(context) * 0.045),
            ),
            //Foto de la comunidad , placeholder

            Container(
              width: devicesize.screenWidth(context) * 0.39,
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
                      "Psychomood",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: devicesize.screenHeight(context) * 0.017,
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
                            fontSize: devicesize.screenHeight(context) * 0.014,
                          ),
                        ),
                        Text(
                          quickstrikeType,
                          style: TextStyle(
                              color: Color(0xff3C8FA7),
                              fontSize:
                                  devicesize.screenHeight(context) * 0.014,
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
                          fontSize: devicesize.screenHeight(context) * 0.014,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.quickStrikePost.modelo,
                          style: TextStyle(
                              color: Color(0xff3C8FA7),
                              fontSize:
                                  devicesize.screenHeight(context) * 0.014,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.fade,
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
                          color: Colors.black,
                          blurRadius: 5.0,
                          spreadRadius: 5.0,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(50),
                      color:
                          isEnlisted ? Colors.green : custcolor.lightBlueColor),
                  // set needed date

                  child: Padding(
                    padding: EdgeInsets.only(
                        top: devicesize.screenHeight(context) * 0.014),
                    child: StreamBuilder(
                        stream: Stream.periodic(Duration(seconds: 1), (i) => i),
                        builder: (BuildContext context,
                            AsyncSnapshot<int> snapshot) {
                          DateFormat format = DateFormat("mm:ss");
                          int now = DateTime.now().millisecondsSinceEpoch;
                          Duration remaining =
                              Duration(milliseconds: estimateTs - now);
                          var dateString =
                              '${remaining.inHours}:${format.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}';
                          return Text(
                            dateString,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: isEnlisted
                                    ? Colors.white
                                    : Color(0xff3C8FA7),
                                fontFamily: 'Raleway',
                                fontSize:
                                    devicesize.screenWidth(context) * 0.05),
                          );
                        }),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.only(
                      top: devicesize.screenHeight(context) * 0.05),
                  iconSize: 25,
                  color: Colors.white,
                  alignment: Alignment.bottomLeft,
                  icon: Icon(Icons.expand_more),
                  onPressed: () => setState(() {
                    print("xd");
                    isExpanded = !isExpanded;
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
      isExpanded
          ? Container(
              padding: EdgeInsets.only(bottom: 15),
              width: devicesize.screenWidth(context),
              color: Colors.black,
              child: Column(
                children: <Widget>[
                  Container(
                    width: devicesize.screenWidth(context),
                    color: Colors.black,
                    padding:
                        EdgeInsets.all(devicesize.screenHeight(context) * 0.01),
                    child: Text(
                      "XD XDXDXDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD DGSASASDDF XXXXXXXFSD LOREM IMPOSUSM HAHH LOOK JUST GETS SLKA  1200 EN EL BOLSILLO TENGO SIROPE LEAN HAHA XANAX",
                      style: TextStyle(
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
                            left: devicesize.screenHeight(context) * 0.01),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left:
                                      devicesize.screenWidth(context) * 0.208),
                              height: devicesize.screenHeight(context) * 0.0775,
                              width: devicesize.screenWidth(context) * 0.355,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(
                                      devicesize.screenWidth(context) * 0.03),
                                  color: Colors.orange),
                            ),
                            Container(
                              height: devicesize.screenHeight(context) * 0.0775,
                              width: devicesize.screenWidth(context) * 0.25,
                              padding: EdgeInsets.only(
                                  left:
                                      devicesize.screenWidth(context) * 0.104),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(
                                    devicesize.screenWidth(context) * 0.03),
                                color: Colors.yellow,
                              ),
                            ),
                            Container(
                              height: devicesize.screenHeight(context) * 0.0775,
                              width: devicesize.screenHeight(context) * 0.0775,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(
                                      devicesize.screenWidth(context) * 0.03),
                                  color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: devicesize.screenWidth(context) * 0.4,
                            right: devicesize.screenHeight(context) * 0.01),
                        child: GestureDetector(
                          //TODO: metodo de participacion con el servicio de firebase y aviso de compra en caso de ser ganador
                          onTap: () {
                            setState(() {
                              print("pulsaste we");
                              isEnlisted = !isEnlisted;
                              isEnlisted ? animationSelector ='RTOG' : animationSelector = 'GTOR';
                            });
                          },
                          child: Container(
                            height: devicesize.screenHeight(context) * 0.0678,
                            width: devicesize.screenWidth(context) * 0.1921,
                            child: FlareActor(
                              'assets/animations/quickstrikeAnimation.flr',
                              fit: BoxFit.fill,
                              animation: animationSelector ,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: devicesize.screenHeight(context) * 0.0221),
                    child: Container(
                      height: devicesize.screenHeight(context) * 0.0357,
                      width: devicesize.screenWidth(context) * 0.912,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Escribe un comentario',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Raleway',
                              fontSize:
                                  devicesize.screenHeight(context) * 0.018,
                              fontStyle: FontStyle.italic),
                          contentPadding: EdgeInsets.only(
                              top: devicesize.screenHeight(context) * 0.01),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          fillColor: Color(0xff15232B),
                          filled: true,
                          prefixIcon: Icon(Icons.add_comment,
                              color: Colors.white,
                              size: devicesize.screenHeight(context) * 0.023),
                        ),
                        controller: commentController,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container()
    ]);
  }
}

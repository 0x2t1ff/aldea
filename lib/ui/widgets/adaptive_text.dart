import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import "../shared/ui_helpers.dart" as devicesize;

class AdaptiveText extends StatefulWidget {
  final String descriptionText;

  final int maxLength;
  final TextStyle styleText;
  AdaptiveText(this.descriptionText, this.maxLength, this.styleText);

  @override
  _AdaptiveTextState createState() => _AdaptiveTextState();
}

class _AdaptiveTextState extends State<AdaptiveText> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return Container(
constraints: BoxConstraints(
  maxWidth: screenWidth(context) * 0.96,
),
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: widget.descriptionText.length < 110
          ? new Text(widget.descriptionText, style: widget.styleText)
          : new Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      right: devicesize.screenWidth(context) * 0.06,
                      left: devicesize.screenWidth(context) * 0.06,
                      top: devicesize.screenHeight(context) * 0.02),
                  width: devicesize.screenWidth(
                    context,
                  ),
                  child: GestureDetector(
                    child: Text(
                      flag
                          ? widget.descriptionText
                                  .substring(0, widget.maxLength) +
                              " ...show more"
                          : widget.descriptionText,
                      style: widget.styleText,
                    ),
                    onTap: () {
                      setState(() {
                        flag = !flag;
                        print(flag.toString());
                      });
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

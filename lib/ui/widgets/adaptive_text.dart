import 'package:aldea/ui/shared/app_colors.dart';
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
                  width: devicesize.screenWidth(
                    context,
                  ),
                  child: GestureDetector(
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: flag
                              ? widget.descriptionText.length > widget.maxLength
                                  ? widget.descriptionText
                                      .substring(0, widget.maxLength)
                                  : widget.descriptionText
                              : widget.descriptionText,
                          style: widget.styleText,
                        ),
                        TextSpan(
                            text: flag
                                ? widget.descriptionText.length >
                                        widget.maxLength
                                    ? "...show more"
                                    : ""
                                : "",
                            style: TextStyle(
                                fontFamily: "Raleway",
                                color: blueTheme,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                fontSize: 14))
                      ]),
                    ),

                    //Text(
                    // flag
                    //    ? widget.descriptionText.length > widget.maxLength
                    //       ? widget.descriptionText
                    //              .substring(0, widget.maxLength) +
                    //         " ...show more"
                    //     : widget.descriptionText
                    //: widget.descriptionText,
                    // style: widget.styleText,
                    //),
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

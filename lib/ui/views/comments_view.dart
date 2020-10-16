import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/bottom_filler.dart';
import 'package:aldea/ui/widgets/comment_widget.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:aldea/viewmodels/comments_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CommentsView extends StatelessWidget {
  final Map ids;
  const CommentsView(this.ids);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return ViewModelBuilder<CommentsViewModel>.reactive(
      viewModelBuilder: () => CommentsViewModel(),
      onModelReady: (model) {
        model.fetchComments(ids);
      },
      builder: (context, model, child) => !model.busy
          ? Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: backgroundColor,
              body: Column(
                children: <Widget>[
                  NotchFiller(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    height: usableScreenHeight(context) * 0.1,
                    alignment: Alignment.centerLeft,
                    color: backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'ALDEA',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Thinoo',
                              fontSize: 40),
                        ),
                        SizedBox(
                            height: 50,
                            child: Image.asset('assets/images/hoguera.png'))
                      ],
                    ),
                  ),
                  Container(
                    color: darkGrey,
                    width: screenWidth(context),
                    margin: EdgeInsets.symmetric(
                        vertical: screenHeight(context) * 0.005),
                    child: GestureDetector(
                      onTap: () => model.goBack(),
                      child: Container(
                          child: Row(
                        children: <Widget>[
                          Icon(Icons.arrow_back_ios,
                              color: almostWhite,
                              size: screenWidth(context) * 0.06),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth(context) * 0.02),
                            child: Text("Comentarios",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Raleway',
                                    color: almostWhite,
                                    fontSize: screenWidth(context) * 0.06)),
                          )
                        ],
                      )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: backgroundColor,
                      width: screenWidth(context),
                      height: screenHeight(context) * 0.75,
                      child: ListView.builder(
                          reverse: true,
                          padding: EdgeInsets.all(0),
                          itemCount: model.comments.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: screenHeight(context) * 0.005),
                                child: CommentWidget(
                                    model.comments[index],
                                    () => model
                                        .navigate(model.comments[index].uid)));
                          }),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: darkGrey,
                    ),
                    width: screenWidth(context),
                    height: screenHeight(context) * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: screenWidth(context) * 0.02),
                          width: screenWidth(context) * 0.7,
                          height: screenHeight(context) * 0.045,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: TextFormField(
                            controller: textController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  bottom: screenHeight(context) * 0.015,
                                  left: screenWidth(context) * 0.03),
                              hintText: "   Envia un comentario...",
                              hintStyle: TextStyle(
                                  color: Colors.blueGrey[300],
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                color: almostWhite,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            model.postComment(textController.text);
                            textController.text = "";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: blueTheme,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(200))),
                            width: screenWidth(context) * 0.16,
                            height: screenHeight(context) * 0.045,
                            child: Icon(
                              Icons.send,
                              color: almostWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BottomFiller()
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(blueishGreyColor),
              ),
            ),
    );
  }
}

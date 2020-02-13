import 'package:aldea/ui/widgets/bottom_filler.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import '../../viewmodels/communities_view_model.dart';
import '../../ui/shared/ui_helpers.dart';
import '../widgets/notch_filler.dart';

class CommunitiesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CommunitiesViewModel>.withConsumer(
      viewModel: CommunitiesViewModel(),
      builder: (context, model, child) =>Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: usableScreenHeight(context) * 0.8,
              padding: EdgeInsets.only(left: 15, top: 20, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Color(0xff3C8FA7),
                              ),
                              horizontalSpaceSmall,
                              Text(
                                "Top de la semana",
                                style: TextStyle(
                                    color: Color(0xffb5b5b5), fontSize: 29),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Comunidades",
                              style: TextStyle(
                                color: Color(0xffb5b5b5),
                                fontSize: 29,
                              )),
                          Expanded(
                            child: Container(
                                width: double.infinity,
                                child: GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  shrinkWrap: false,
                                  primary: true,
                                  crossAxisCount: 3,
                                  children: <Widget>[
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ;
  }
}

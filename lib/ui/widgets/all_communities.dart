import 'package:aldea/models/community.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/community_preview.dart';
import 'package:aldea/viewmodels/communities_view_model.dart';
import 'package:flutter/material.dart';

class AllCommunities extends StatefulWidget {
  final CommunitiesViewModel model;

  const AllCommunities({Key key, this.model}) : super(key: key);

  @override
  _AllCommunitiesState createState() => _AllCommunitiesState();
}

class _AllCommunitiesState extends State<AllCommunities> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent)
        widget.model.loadMoreCommunities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Container(
        height: usableScreenHeight(context),
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            verticalSpaceSmall,
            Text("Comunidades",
                style: TextStyle(
                  color: Color(0xffb5b5b5),
                  fontSize: 29,
                )),
            CommunityPreview(
              community: widget.model.selectedCommunity,
              model: widget.model,
              cancel: () {
                setState(() {
                  widget.model.selectedCommunity = null;
                });
              },
            ),
            Expanded(
                child: ListView.builder(
              primary: false,
              padding: EdgeInsets.all(0),
              itemCount: (widget.model.communitiesList.length / 3).ceil(),
              itemBuilder: (context, index) {
                return CommunitiesRow(
                    model: widget.model,
                    list: widget.model.communitiesList
                        .getRange(
                            index * 3,
                            widget.model.communitiesList.length >
                                    (index * 3 + 3)
                                ? (index * 3 + 3)
                                : widget.model.communitiesList.length)
                        .toList());
              },
            ))
          ],
        ),
      ),
    );
  }
}

class CommunitiesRow extends StatefulWidget {
  const CommunitiesRow({Key key, this.list, this.model}) : super(key: key);
  final CommunitiesViewModel model;

  @override
  _CommunitiesRowState createState() => _CommunitiesRowState();
  final List<Community> list;
}

class _CommunitiesRowState extends State<CommunitiesRow> {
  Community selectedCommunity;

  Widget buildCommunity(Community c) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCommunity = c;
        });
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Color(0xff223C47),
              image: c.bkdPicUrl != null
                  ? DecorationImage(
                      image: NetworkImage(c.iconPicUrl),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.1), BlendMode.srcOver))
                  : null),
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xff223C47).withOpacity(0.6),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14))),
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              c.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  void unselectCommunity() {
    setState(() {
      selectedCommunity = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CommunityPreview(
          community: selectedCommunity != null ? selectedCommunity : null,
          cancel: unselectCommunity,
          model: widget.model,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Flexible(child: buildCommunity(widget.list[0])),
              SizedBox(width: 15),
              Flexible(
                  child: widget.list.length > 1
                      ? buildCommunity(widget.list[1])
                      : Container()),
              SizedBox(width: 15),
              Flexible(
                  child: widget.list.length > 2
                      ? buildCommunity(widget.list[2])
                      : Container()),
            ],
          ),
        )
      ],
    );
  }
}

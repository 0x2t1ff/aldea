import 'package:aldea/models/comment_model.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';

import '../locator.dart';
import 'base_model.dart';

class CommentsViewModel extends BaseModel {
  FirestoreService _firestoreService = locator<FirestoreService>();
  NavigationService _navigationService = locator<NavigationService>();
  List<CommentModel> _comments;
  List<CommentModel> get comments => _comments;

  Map mapId;
  Future fetchComments(Map ids) async {
    mapId = ids;
    if (ids.values.length == 1) {
      setBusy(true);
      var commentList = await _firestoreService.getComments(mapId["postId"]);
      if (commentList is List<CommentModel>) {
        _comments = commentList;
        setBusy(false);
        notifyListeners();
      } else {
        print(" error , it was not a list<CommentModel>");
      }
    } else {
      setBusy(true);
      var commentList = await _firestoreService.getUserComments(
          mapId['postId'], mapId["communityId"]);

      if (commentList is List<CommentModel>) {
        _comments = commentList;
        setBusy(false);
        notifyListeners();
      } else {
        print(" error , it was not a list<CommentModel>");
      }
    }
  }

  Future postComment(String text) async {
    print(mapId.toString() + " communityId");
    if (mapId["communityId"] == null) {
      _firestoreService.postComment(
          mapId['postId'], text, currentUser.name, currentUser.uid);
    } else {
      _firestoreService.postUserComment(mapId['communityId'], mapId['postId'],
          text, currentUser.name, currentUser.uid);
    }
    _comments.add(CommentModel(date: DateTime.now().toString(), name: currentUser.name, uid: currentUser.uid, text: text));
    notifyListeners();
  }

  void goBack() {
    _navigationService.pop();
  }
}

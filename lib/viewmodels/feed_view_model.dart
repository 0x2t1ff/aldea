import 'package:aldea/models/post_model.dart';
import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/services/firestore_service.dart';

import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class FeedViewModel extends BaseModel{
  
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<PostModel> _posts;
  List<PostModel> get posts => _posts;

  Future fetchPosts() async {
   setBusy(true);
   var quickstrikeResults = await _firestoreService.getFollowingPostsOnceOff(currentUser.uid);
    setBusy(true);

  if(quickstrikeResults is List<PostModel>){
    _posts = quickstrikeResults;
    notifyListeners();
  }else{
    //print(_quickstrikes.length.toString());
    await _dialogService.showDialog(
      title: 'La actualizacion de posts ha fallado',
      description: "ha fallado XD asi al menos no crashea ",
    );
   }
  }
}
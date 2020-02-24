import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/services/firestore_service.dart';

import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class QuickStrikeViewModel extends BaseModel{
  
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<QuickStrikePost> _quickstrikes;
  List<QuickStrikePost> get posts => _quickstrikes;

  Future fetchPosts() async {
    setBusy(true);
    var quickstrikeResults = await _firestoreService.getPostsOnceOff();
    setBusy(false);

    if(quickstrikeResults is List<QuickStrikePost>){
      _quickstrikes = quickstrikeResults;
      notifyListeners();
    }else{
      await _dialogService.showDialog(
        title: 'La actualizacion de quickstrikes ha fallado',
        description: quickstrikeResults,
      );
    }
  }
}
import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/services/firestore_service.dart';

import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class QuickStrikeViewModel extends BaseModel{
  
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<QuickStrikeModel> _quickstrikes;
  List<QuickStrikeModel> get posts => _quickstrikes;

  Future fetchPosts() async {
   setBusy(true);
   var quickstrikeResults = await _firestoreService.getQuickstrikes(currentUser.uid);
    setBusy(true);

  if(quickstrikeResults is List<QuickStrikeModel>){
    _quickstrikes = quickstrikeResults;
    notifyListeners();
  }else{
    //print(_quickstrikes.length.toString());
    await _dialogService.showDialog(
      title: 'La actualizacion de quickstrikes ha fallado',
      description: "ha fallado XD asi al menos no crashea ",
    );
   }
  }
}
import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/utils/random_id_generator.dart';

import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class QuickStrikeViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  Stream _quickstrikes;
  Stream get posts => _quickstrikes;

  Future fetchPosts() async {
    setBusy(true);
    var quickstrikeResults =
        await _firestoreService.getQuickstrike(currentUser.uid);

    if (quickstrikeResults is Stream<dynamic>) {
      _quickstrikes = quickstrikeResults;
      setBusy(false);
      notifyListeners();
    } else {
      //print(_quickstrikes.length.toString());
      await _dialogService.showDialog(
        title: 'La actualizacion de quickstrikes ha fallado',
        description: "ha fallado XD asi al menos no crashea ",
      );
    }
  }

  Future joinQuickstrike(QuickStrikePost quickstrike) async {
    Map<String, dynamic> _quickstrike = quickstrike.toMap();
    _quickstrike.putIfAbsent("randomId", () => RandomIdGenerator.generateId());
    _quickstrike.putIfAbsent("user", () => currentUser.toJson());
    await _firestoreService.joinQuickstrike(currentUser.uid, _quickstrike);
    currentUser.onGoingQuickstrikes.add(quickstrike.id);
  }

  Future quitQuickstrike(QuickStrikePost quickstrike) async {
    currentUser.onGoingQuickstrikes.remove(quickstrike.id);
    await _firestoreService.quitQuickstrike(currentUser.uid, quickstrike.id);
  }
}

import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/utils/random_id_generator.dart';

import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class QuickStrikeViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

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
    notifyListeners();
  }
  Future heroAnimation(List url){
    _navigationService.navigateTo(HeroScreenRoute, false, arguments: url);
  }

  Future<bool> checkParticipatingQuickstrike(String qid) async {
    bool result = await _firestoreService.getParticipatingQuickstrikes(
        currentUser.uid, qid);
    print(" the result of the check is" + result.toString() + qid);
    return result;
  }

  Future submitResult(String id) {
    _firestoreService.submitQuickstrikeResult(id, currentUser.uid);
  }

  Future failedQuickstrike() async {
    await _dialogService.showDialog(
        title: "Wrong Answer", description: "Sorry! Try again next time.");
  }

    Future<bool> onWillPop() async {
    var response = await _dialogService.showConfirmationDialog(
        description: "",
        confirmationTitle: "Si",
        cancelTitle: "No",
        title: "¿Estas seguro que quieres salir de la app?");
    return response.confirmed;
  }
}

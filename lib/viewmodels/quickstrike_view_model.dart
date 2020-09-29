import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/utils/random_id_generator.dart';
import 'dart:math';
import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class QuickStrikeViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<QuickStrikePost> _quickstrikes;
  List<QuickStrikePost> get posts => _quickstrikes;
  bool showEmptyDialog = false;
  bool isLoadingMore = false;
  bool quickstrikeActive = false;
  QuickStrikePost activeQuickstrike;
  List randomQuestions = [];
  List participatingIds = [];

  Future loadMorePosts() async {
    isLoadingMore = true;
    notifyListeners();
    var postsToAdd = await _firestoreService.getMoreQuickstrikes(
        currentUser.communities,
        _quickstrikes[_quickstrikes.length - 1].fechaQuickstrike);

    _quickstrikes.addAll(postsToAdd);
    notifyListeners();
  }

//
// ----------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------
//
//
//
//
  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  Future fetchPosts() async {
    participatingIds =
        await _firestoreService.getParticipatingQuickstrikes(currentUser.uid);
        print(participatingIds);
    setBusy(true);
    var communities = currentUser.communities;
    var quickstrikeResults =
        await _firestoreService.getQuickstrikes(communities);
    if (quickstrikeResults.isEmpty) {
      showEmptyDialog = true;
    }

    if (quickstrikeResults is List<QuickStrikePost>) {
      _quickstrikes = quickstrikeResults;
      setBusy(false);
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'La actualizacion de quickstrikes ha fallado',
        description: "",
      );
    }

    Future.delayed(
        Duration(
            seconds: posts.last.fechaQuickstrike.seconds -
                DateTime.now().second), () {
      if (participatingIds.contains(posts.last.id)) {
        if (posts.first.isQuestion) {
          randomQuestions.addAll(posts.first.wrongAnswers);
          randomQuestions.add(posts.first.correctAnswer);
          randomQuestions = shuffle(randomQuestions);
          print(randomQuestions);

          activeQuickstrike = posts.first;
          quickstrikeActive = true;
          notifyListeners();
          return;
        }
        if (posts.first.isGame) {
          activeQuickstrike = posts.first;
          quickstrikeActive = true;
          notifyListeners();
          return;
        }
        if (posts.first.isRandom) {
          fetchPosts();
        }
      } else {
        fetchPosts();
      }
    });
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

  Future heroAnimation(List url) {
    _navigationService.navigateTo(HeroScreenRoute, false, arguments: url);
  }



  Future submitResult(String id) {
    _firestoreService.submitQuickstrikeResult(id, currentUser.uid);
    fetchPosts();
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

  void activateQuickstrike(int index) {
    quickstrikeActive = true;
    activeQuickstrike = posts[index];
    notifyListeners();
  }

  void finishQuickstrike() {
    randomQuestions.clear();
    quickstrikeActive = false;
    fetchPosts();
  }

  void hideDialog() {
    showEmptyDialog = false;
    notifyListeners();
  }
}

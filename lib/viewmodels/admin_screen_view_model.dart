import 'dart:io';

import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/community_creation_request.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/services/rtdb_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class AdminScreenViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<CommunityCreationRequest> _requests;
  List<CommunityCreationRequest> get requests => _requests;
  File selectedImage;

  Future getAdminRequests() async {
    setBusy(true);
    var adminRequests = await _firestoreService.getAdminRequests();

    if (adminRequests is List<CommunityCreationRequest>) {
      print("it was a communitycreationrequest");
      _requests = adminRequests;
      setBusy(false);
      notifyListeners();
    } else {
      print("well , it was not");
      await _dialogService.showDialog(
          title: 'La actualizacion de solicitudes ha fallado');
    }
  }

  Future seeRequest(CommunityCreationRequest request){
    _navigationService.navigateTo(DetailedCommunityCreationViewRoute, false, arguments: request );
    
  }
}

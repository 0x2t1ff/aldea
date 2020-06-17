import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/community.dart';
import 'package:aldea/models/community_request.dart';
import 'package:aldea/models/post_model.dart';
import 'package:aldea/models/product.dart';
import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/services/cloud_storage_service.dart';
import 'package:aldea/services/dialog_service.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/viewmodels/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'base_model.dart';
import 'dart:io';
import '../utils/image_selector.dart';
import '../locator.dart';

class CommunityViewModel extends BaseModel {
  CommunityViewModel(this.community);

  var isShowingPopup = false;
  var isUploading = false;
  var isQuickstrike = true;
  final Community community;
  Map<dynamic, dynamic> followersDoc;
  File firstImage;
  final postDescController = TextEditingController();
  final Map<String, List<Product>> products = {};
  final qsDescController = TextEditingController();
  final qsQuantityController = TextEditingController();
  QuickStrikePost quickStrikePost = QuickStrikePost(
    isGame: false,
    isRandom: true,
    isQuestion: false,
    finished: false,
    isEmpty: false,
  );

  List<CommunityRequest> requests;
  File secondImage;
  DateTime selectedDate;
  File thirdImage;
  String dropDownValue;
  String modelDropdown;

  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  void goToRequests() {
    _navigationService.navigateTo(RequestsViewRoute, false,
        arguments: ({"requests": requests, "uid": community.uid}));
  }

  void goToSettings(Community community) {
    _navigationService.navigateTo(CommunitySettingsViewRoute, false,
        arguments: community);
  }

  void setIsQuickstrike(bool value) {
    isQuickstrike = value;
    notifyListeners();
  }

  void setIsShowingPopup(bool value) {
    isShowingPopup = value;
    notifyListeners();
  }

  void setDropdownValue(String value) {
    dropDownValue = value;
    notifyListeners();
  }

  void setModelDropdown(String value) {
    modelDropdown = value;
    notifyListeners();
  }

  Future selectFirstImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      firstImage = tempImage;
      notifyListeners();
    }
  }

  Future selectSecondImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      secondImage = tempImage;
      notifyListeners();
    }
  }

  Future selectThirdImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      thirdImage = tempImage;
      notifyListeners();
    }
  }

  void cancelChanges() {
    isShowingPopup = false;
    dropDownValue = null;
    modelDropdown = null;
    qsDescController.text = '';
    postDescController.text = '';
    qsQuantityController.text = '';
    firstImage = null;
    secondImage = null;
    thirdImage = null;
    selectedDate = null;
    notifyListeners();
  }

  Future getFollowersDoc() async {
    followersDoc =
        await _firestoreService.getCommunityFollowersDoc(community.uid);
  }

  Future getRequests(String communityId) async {
    setBusy(true);
    var data = await _firestoreService.getCommunityRequests(communityId);
    requests = data.map((doc) => CommunityRequest.fromData(doc.data)).toList();
    setBusy(false);
  }

  Future fetchProducts(String communityId) async {
    setBusy(true);
    var documents =
        await _firestoreService.getProductsFromCommunity(communityId);
    documents.forEach((document) {
      products.putIfAbsent(document.data['name'], () {
        List<Product> list = [];
        document.data['products']
            .forEach((item) => list.add(Product.fromData(item)));
        return list;
      });
    });
    print(products);
    setBusy(false);
  }

  List<String> getProductNames() {
    List<String> namez = [];
    products.forEach((key, value) {
      value.forEach((element) => namez.add(element.name));
    });

    return namez;
  }

  Future<Null> selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(hours: 2)),
        firstDate: DateTime.now().add(Duration(hours: 2)),
        lastDate: DateTime.now().add(Duration(days: 365)));
    final TimeOfDay timePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1));
    picked = DateTime.utc(picked.year, picked.month, picked.day,
        timePicked.hour, timePicked.minute);
    if (picked != null &&
        picked.isAfter(DateTime.now().add(Duration(hours: 1)))) {
      selectedDate = picked;
      notifyListeners();
    }
  }

  void uploadPost() async {
    if (postDescController.text.isEmpty) {
      _dialogService.showDialog(
          title: "Error",
          description: "Debes escribir una descripcion",
          buttonTitle: "Entendido");
      return null;
    }
    if (firstImage == null && secondImage == null && thirdImage == null) {
      _dialogService.showDialog(
          title: "Error",
          description: "Debes añadir al menos 1 imagen.",
          buttonTitle: "Entendido");
      return null;
    }

    isUploading = true;
    var imagesList = [];
    if (firstImage != null) {
      var image = await _cloudStorageService.uploadPostImages(
          firstImage, community.uid);
      imagesList.add(image.imageUrl);
    }
    if (secondImage != null) {
      var image = await _cloudStorageService.uploadPostImages(
          secondImage, community.uid);
      imagesList.add(image.imageUrl);
    }
    if (thirdImage != null) {
      var image = await _cloudStorageService.uploadPostImages(
          thirdImage, community.uid);
      imagesList.add(image.imageUrl);
    }
    PostModel post = PostModel(
      fechaQuickstrike: Timestamp.now(),
      amount: null,
      commentCount: 0,
      communityId: community.uid,
      communityName: community.name,
      avatarUrl: community.iconPicUrl,
      description: postDescController.text,
      imageUrl: imagesList,
      isAnnouncement: false,
      isGame: false,
      isLista: false,
      isRandom: false,
      isResult: false,
      likes: [],
      modelo: null,
      title: null,
      userId: null,
      winners: null,
    );
    var postId = await _firestoreService.addPost(post.toMap());
    List<dynamic> postsList = followersDoc["posts"] ?? [];
    postsList.add({'id': postId, 'date': post.fechaQuickstrike});
    await _firestoreService.addPostToFollowing(
        community.uid, postsList, post.fechaQuickstrike);
    isUploading = false;
    isShowingPopup = false;
    firstImage = null;
    secondImage = null;
    thirdImage = null;
    selectedDate = null;
    notifyListeners();
  }

  void uploadQuickStrike() async {
    if (qsDescController.text.isEmpty) {
      _dialogService.showDialog(
          title: "Error",
          description: "Debes escribir una descripcion",
          buttonTitle: "Entendido");
      return null;
    }
    if (firstImage == null && secondImage == null && thirdImage == null) {
      _dialogService.showDialog(
          title: "Error",
          description: "Debes añadir al menos 1 imagen.",
          buttonTitle: "Entendido");
      return null;
    }
    if (dropDownValue == null) {
      _dialogService.showDialog(
          title: "Error",
          description: "Debes elegir el tipo de Venta Rapida",
          buttonTitle: "Entendido");
      return null;
    }
    if (modelDropdown == null) {
      _dialogService.showDialog(
          title: "Error",
          description: "Debes elegir el modelo de producto.",
          buttonTitle: "Entendido");
      return null;
    }
    if (selectedDate == null) {
      _dialogService.showDialog(
          title: "Error",
          description: "Debes elegir una fecha",
          buttonTitle: "Entendido");
      return null;
    }

    isUploading = true;
    notifyListeners();
    quickStrikePost.description = qsDescController.text;
    quickStrikePost.communityName = community.name;
    quickStrikePost.modelo = modelDropdown;
    quickStrikePost.amount = int.parse(qsQuantityController.text);
    quickStrikePost.cid = community.uid;
    quickStrikePost.fechaQuickstrike = Timestamp.fromMillisecondsSinceEpoch(
        selectedDate.millisecondsSinceEpoch);

    var imagesList = [];
    if (firstImage != null) {
      var image = await _cloudStorageService.uploadQuickstrikmImages(
          firstImage, community.uid);
      imagesList.add(image.imageUrl);
    }
    if (secondImage != null) {
      var image = await _cloudStorageService.uploadQuickstrikmImages(
          secondImage, community.uid);
      imagesList.add(image.imageUrl);
    }
    if (thirdImage != null) {
      var image = await _cloudStorageService.uploadQuickstrikmImages(
          thirdImage, community.uid);
      imagesList.add(image.imageUrl);
    }
    quickStrikePost.imageUrl = imagesList;
    var qsId = await _firestoreService.addQuickstrike(quickStrikePost);
    List<dynamic> quickstrikeList = followersDoc["quickstrikes"] ?? [];
    quickstrikeList.add({'id': qsId, 'date': quickStrikePost.fechaQuickstrike});
    await _firestoreService.addQsToFollowing(
        community.uid, quickstrikeList, quickStrikePost.fechaQuickstrike);
    isUploading = false;
    isShowingPopup = false;
    quickStrikePost = QuickStrikePost(
      isGame: false,
      isRandom: true,
      isQuestion: false,
      finished: false,
      isEmpty: false,
    );
    firstImage = null;
    secondImage = null;
    thirdImage = null;
    selectedDate = null;
    notifyListeners();
  }
}

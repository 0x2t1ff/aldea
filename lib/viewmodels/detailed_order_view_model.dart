import 'base_model.dart';
import 'package:aldea/models/order.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import '../locator.dart';
import 'package:aldea/models/user_model.dart';
import 'package:aldea/constants/route_names.dart';

class DetailedOrderViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  List list = [];

  String id;
  Order order;
  User user;
  setData() {
    order = list[0];
    id = list[1];
    getUserData();
  }

  getUserData() async {
    user = await _firestoreService.getUser(order.userId);
    print(user);
    notifyListeners();
  }

  goToUser() {
    _navigationService.navigateTo(OtherProfileViewRoute, false,
        arguments: user.uid);
  }

  dismissOrder() {
    print(order.id);
    _firestoreService.dismissOrder(id, order.id);
  }
}

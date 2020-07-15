import 'package:aldea/constants/route_names.dart';
import 'package:aldea/locator.dart';
import 'package:aldea/models/product.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';

import 'base_model.dart';

class MarketViewModel extends BaseModel {
  Map<Product, int> cart = {};
  MarketViewModel(this.uid, this.products);
  var totalItems = 0;
  final Map<String, List<Product>> products;
  Product selectedProduct;
  String firstCategory;
  List<Product> firstProducts;
  bool isProductSelected = false;
  bool isShowingMore = false;
  List<Product> newestProducts;
  final String uid;
  bool isShowingCart = false;

  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void addProductToCart(Product product) {
    if (cart.containsKey(product)) {
      cart[product] += 1;
    } else {
      cart.putIfAbsent(product, () => 1);
    }
    totalItems += 1;
    notifyListeners();
  }

  void removeProductToCart(Product product) {
    if (cart.containsKey(product)) {
      if (cart[product] <= 1)
        cart.remove(product);
      else
        cart[product] -= 1;
    }
    totalItems -= 1;
    notifyListeners();
  }

  void showMore() {
    isShowingMore = true;
    notifyListeners();
  }

  void showLanding() {
    isShowingMore = false;
    notifyListeners();
  }

  void unselectProduct() {
    isProductSelected = false;
    notifyListeners();
  }

  void selectProduct(Product product) {
    isProductSelected = true;
    selectedProduct = product;
    notifyListeners();
  }

  Future setFirstProducts() {
    setBusy(true);
    var keys = products.keys;
    print(keys);
    var longest = 0;
    String longestKey;
    keys.forEach((key) {
      var current = products[key];
      print(current);
      if (current.length > longest) {
        longest = current.length;
        longestKey = key;
      }
    });
    print(longestKey);
    firstCategory = longestKey;
    firstProducts = products[longestKey];
    setNewItems();
    setBusy(false);
  }

  void setNewItems() {
    List<Product> allProducts = [];
    products.forEach((key, value) {
      allProducts.addAll(value);
    });
    allProducts.sort((a, b) => a.dateAdded.compareTo(b.dateAdded));
    newestProducts = allProducts;
  }

  void navigateToCartView() {
    isShowingCart = true;
    notifyListeners();
  }

  void backFromCartView() {
    isShowingCart = false;
    notifyListeners();
  }

  double getTotalPrice() {
    var totalPrice = 0.0;
    cart.forEach((key, value) {
      totalPrice += key.price * value;
    });
    return totalPrice;
  }
}

import 'package:aldea/locator.dart';
import 'package:aldea/models/product.dart';
import 'package:aldea/services/firestore_service.dart';

import 'base_model.dart';

class MarketViewModel extends BaseModel {
  MarketViewModel(this.uid, this.products);
  final Map<String, List<Product>> products;
  Product selectedProduct;
  String firstCategory;
  List<Product> firstProducts;
  bool isProductSelected = false;
  bool isShowingMore = false;
  List<Product> newestProducts;
  final String uid;

  final FirestoreService _firestoreService = locator<FirestoreService>();

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
}

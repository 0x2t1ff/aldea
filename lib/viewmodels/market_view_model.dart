import 'package:aldea/constants/languages.dart';
import 'package:aldea/locator.dart';
import 'package:aldea/models/product.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/dialog_service.dart';

import 'base_model.dart';

class MarketViewModel extends BaseModel {
  MarketViewModel(this.uid, this.products);
  final Map<String, List<Product>> products;
  Product selectedProduct;
  String firstCategory;
  bool isShowingCart = false;
  List<Product> cartProducts = [];
  List<Product> firstProducts;
  double cartPrice = 0;
  bool isProductSelected = false;
  bool isShowingMore = false;
  List<Product> newestProducts;
  final String uid;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  bool isSubmitting = false;

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
    return null;
  }

  void setNewItems() {
    List<Product> allProducts = [];
    products.forEach((key, value) {
      allProducts.addAll(value);
    });
    allProducts.sort((a, b) => a.dateAdded.compareTo(b.dateAdded));
    newestProducts = allProducts;
  }

  void openCart() {
    isShowingCart = !isShowingCart;
    notifyListeners();
  }

  void addToCart(Product product) {
    cartProducts.add(product);
    cartPrice += product.price;
    notifyListeners();
    print(cartProducts);
  }

  void removeFromCart(int index) {
    cartPrice -= cartProducts[index].price;
    cartProducts.removeAt(index);
    notifyListeners();
  }

  Future<void> checkout() async  {
    isSubmitting = true;
    notifyListeners();
    await _firestoreService.submitOrder(cartProducts, currentUser.uid, uid);
    cartPrice = 0.0;
    cartProducts.clear();
    isSubmitting = false;
    notifyListeners();
    await _dialogService.showDialog(title: languages[currentLanguage]["order sent"], description: languages[currentLanguage]["mod contact"]);
    return null;
  }
}

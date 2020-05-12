import 'package:aldea/locator.dart';
import 'package:aldea/models/product.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/viewmodels/base_model.dart';

class MarketViewModel extends BaseModel {
  MarketViewModel(this.uid);

  Product selectedProduct;
  String firstCategory;
  List<Product> firstProducts;
  bool isProductSelected = false;
  bool isShowingMore = false;
  List<Product> newestProducts;
  final Map<String, List<Product>> products = {};
  final String uid;

  final FirestoreService _firestoreService = locator<FirestoreService>();

  Future fetchProducts() async {
    setBusy(true);
    var documents = await _firestoreService.getProductsFromCommunity(uid);
    documents.forEach((document) {
      products.putIfAbsent(document.data['name'], () {
        List<Product> list = [];
        document.data['products']
            .forEach((item) => list.add(Product.fromData(item)));
        return list;
      });
    });
  }

  void showMore(){
    isShowingMore = true;
    notifyListeners();
  }

  void showLanding(){
    isShowingMore = false;
    notifyListeners();
  }

  void unselectProduct(){
    isProductSelected = false;
    notifyListeners();
  }

  void selectProduct(Product product){
    isProductSelected = true;
    selectedProduct = product;
    notifyListeners();
  }

  Future<dynamic> setFirstProducts() {
    var keys = products.keys;
    var longest = 0;
    String longestKey;
    keys.forEach((key) {
      var current = products[key];
      if (current.length > longest) {
        longest = current.length;
        longestKey = key;
      }
    });
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

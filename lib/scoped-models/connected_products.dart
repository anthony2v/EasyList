import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  Map<String, Product> _products = {};
  String _selectedProductID;
  User _authenticatedUser;
  bool _isLoading = false;

  Future<Null> addProduct(String title, String description, String image,
      double price, String address) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      "title": title,
      "address": address,
      "description": description,
      "imagePath":
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.lnUwNlmh4RTB5_JLWA9XpAHaE8%26pid%3DApi&f=1',
      "price": price,
      "userEmail": _authenticatedUser.email,
      "userID": _authenticatedUser.id
    };
    final Uri url = Uri.parse(
        'https://easylist-4ab01-default-rtdb.firebaseio.com/products.json');
    return http
        .post(url, body: json.encode(productData))
        .then((http.Response response) {
      _isLoading = false;
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['name'] == null) print("Firebase product ID not found!");
      final Product newProduct = new Product(
          id: responseData['name'],
          address: address,
          description: description,
          imagePath: image,
          price: price,
          title: title,
          userEmail: _authenticatedUser.email,
          userID: _authenticatedUser.id);
      _products[newProduct.id] = newProduct;
      notifyListeners();
    });
  }
}

mixin UserModel on ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser =
        User(id: "f13jfi13g4g2g3fwe", email: email, password: password);
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  Map<String, Product> get allProducts {
    return Map.from(_products);
  }

  List<Product> get displayedProducts {
    final List<Product> productsToDisplay = [];
    if (_showFavorites) {
      _products.forEach((_, Product product) {
        if (product.isFavorite) productsToDisplay.add(product);
      });
      return List.from(productsToDisplay);
    }
    return List.from(_products.values);
  }

  int get size {
    return _products.length;
  }

  String get selectedProductID {
    return _selectedProductID;
  }

  Product get selectedProduct {
    if (_selectedProductID == null) return null;
    return _products[_selectedProductID];
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<Null> updateProduct(String title, String description, String image,
      double price, String address,
      [bool isFavorite]) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      "title": title,
      "address": address,
      "description": description,
      "imagePath":
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.lnUwNlmh4RTB5_JLWA9XpAHaE8%26pid%3DApi&f=1',
      "price": price,
      "userEmail": _authenticatedUser.email,
      "userID": _authenticatedUser.id
    };
    final Uri url = Uri.parse(
        'https://easylist-4ab01-default-rtdb.firebaseio.com/products/${selectedProduct.id}.json');
    return http
        .put(url, body: json.encode(productData))
        .then((http.Response response) {
      _isLoading = false;
      final Product updatedProduct = new Product(
          id: selectedProduct.id,
          address: address,
          description: description,
          imagePath: image,
          price: price,
          title: title,
          isFavorite:
              isFavorite != null ? isFavorite : selectedProduct.isFavorite,
          userEmail: selectedProduct.userEmail,
          userID: selectedProduct.userID);
      _products[_selectedProductID] = updatedProduct;
      notifyListeners();
    });
  }

  void deleteProduct() {
    _isLoading = true;
    final String deletedProductID = selectedProduct.id;
    _products.remove(_selectedProductID);
    _selectedProductID = null;
    notifyListeners();
    final Uri url = Uri.parse(
        'https://easylist-4ab01-default-rtdb.firebaseio.com/products/${deletedProductID}.json');
    http.delete(url).then((http.Response response) {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    final Uri url = Uri.parse(
        'https://easylist-4ab01-default-rtdb.firebaseio.com/products.json');
    return http.get(url).then((http.Response response) {
      if (response.body == "null") {
        _isLoading = false;
        notifyListeners();
        return;
      }
      final Map<String, Map<String, dynamic>> productListData =
          Map.castFrom(json.decode(response.body));
      final Map<String, Product> fetchedProductMap = {};
      productListData
          .forEach((String productID, Map<String, dynamic> productData) {
        final Product product = Product(
          id: productID,
          address: productData['address'],
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imagePath: productData['imagePath'],
          userEmail: productData['userEmail'],
          userID: productData['userID'],
        );
        fetchedProductMap[productID] = product;
      });
      _products = fetchedProductMap;
      _isLoading = false;
      notifyListeners();
    });
  }

  void toggleProductFavoriteFlag() {
    if (selectedProduct == null) return;
    final bool newFavoriteStatus = !selectedProduct.isFavorite;
    updateProduct(
      selectedProduct.title,
      selectedProduct.description,
      selectedProduct.imagePath,
      selectedProduct.price,
      selectedProduct.address,
      newFavoriteStatus,
    );
    notifyListeners();
  }

  void selectProduct(String id) {
    _selectedProductID = id;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

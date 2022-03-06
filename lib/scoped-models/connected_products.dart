import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;
  User _authenticatedUser;

  void addProduct(String title, String description, String image, double price,
      String address) {
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
    http
        .post(url, body: json.encode(productData))
        .then((http.Response response) {
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
      _products.add(newProduct);
      notifyListeners();
    });
  }
}

class UserModel extends ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser =
        User(id: "f13jfi13g4g2g3fwe", email: email, password: password);
  }
}

class ProductsModel extends ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites)
      return _products.where((Product element) => element.isFavorite).toList();
    return List.from(_products);
  }

  int get size {
    return _products.length;
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  Product get selectedProduct {
    if (_selectedProductIndex == null) return null;
    return _products[_selectedProductIndex];
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  void updateProduct(String title, String description, String image,
      double price, String address,
      [bool isFavorite]) {
    final Product updatedProduct = new Product(
        address: address,
        description: description,
        imagePath: image,
        price: price,
        title: title,
        isFavorite:
            isFavorite != null ? isFavorite : selectedProduct.isFavorite,
        userEmail: selectedProduct.userEmail,
        userID: selectedProduct.userID);
    _products[_selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    notifyListeners();
  }

  void fetchProducts() {
    final Uri url = Uri.parse(
        'https://easylist-4ab01-default-rtdb.firebaseio.com/products.json');
    http.get(url).then((http.Response response) {
      final Map<String, Map<String, dynamic>> productListData =
          Map.castFrom(json.decode(response.body));
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
        print(product.toString());
      });
    });
  }

  void toggleProductFavoriteFlag() {
    if (selectedProduct == null) return;
    // TODO fix this to take into account displayed products
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

  void selectProduct(int index) {
    _selectedProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

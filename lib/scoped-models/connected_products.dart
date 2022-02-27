import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;
  User _authenticatedUser;

  void addProduct(String title, String description, String image, double price,
      String address) {
    final Product newProduct = new Product(
        address: address,
        description: description,
        imagePath: image,
        price: price,
        title: title,
        userEmail: _authenticatedUser.email,
        userID: _authenticatedUser.id);
    _products.add(newProduct);
    notifyListeners();
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

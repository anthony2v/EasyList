import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;
  bool _showFavorites = false;

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites)
      return products.where((Product element) => element.isFavorite).toList();
    return List.from(products);
  }

  int get size {
    return _products.length;
  }

  Product get selectedProduct {
    if (_selectedProductIndex == null) return null;
    return _products[_selectedProductIndex];
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void updateProduct(Product updatedProduct) {
    _products[_selectedProductIndex] = updatedProduct;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void toggleProductFavoriteFlag() {
    if (selectedProduct == null) return;
    final bool newFavoriteStatus = !selectedProduct.isFavorite;
    final Product updatedProduct = Product(
      address: selectedProduct.address,
      description: selectedProduct.description,
      imagePath: selectedProduct.imagePath,
      price: selectedProduct.price,
      title: selectedProduct.title,
      isFavorite: newFavoriteStatus,
    );
    updateProduct(updatedProduct);
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

import '../models/product.dart';
import './connected_products.dart';

class ProductsModel extends ConnectedProducts {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites)
      return products.where((Product element) => element.isFavorite).toList();
    return List.from(products);
  }

  int get size {
    return products.length;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) return null;
    return products[selectedProductIndex];
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  void updateProduct(String title, String description, String image,
      double price, String address, isFavorite) {
    final Product updatedProduct = new Product(
        address: address,
        description: description,
        imagePath: image,
        price: price,
        title: title,
        isFavorite: isFavorite,
        userEmail: selectedProduct.userEmail,
        userID: selectedProduct.userID);
    products[selectedProductIndex] = updatedProduct;
    selectedProductIndex = null;
  }

  void deleteProduct() {
    products.removeAt(selectedProductIndex);
    selectedProductIndex = null;
    notifyListeners();
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

  void selectProduct(int index) {
    selectedProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

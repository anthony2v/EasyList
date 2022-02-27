import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProducts extends Model {
  List<Product> products = [];
  int selectedProductIndex;
  User authenticatedUser;

  void addProduct(String title, String description, String image, double price,
      String address) {
    final Product newProduct = new Product(
        address: address,
        description: description,
        imagePath: image,
        price: price,
        title: title,
        userEmail: authenticatedUser.email,
        userID: authenticatedUser.id);
    products.add(newProduct);
    selectedProductIndex = null;
    notifyListeners();
  }
}

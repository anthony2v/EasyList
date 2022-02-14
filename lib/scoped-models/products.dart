import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];

  List<Product> get products {
    return List.from(_products);
  }

  int get size {
    return _products.length;
  }

  void addProduct(Product product) {
    _products.add(product);
  }

  void updateProduct(int index, Product updatedProduct) {
    _products[index] = updatedProduct;
  }

  void deleteProduct(int index) {
    _products.removeAt(index);
  }
}

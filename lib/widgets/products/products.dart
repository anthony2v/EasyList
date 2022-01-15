import 'package:flutter/material.dart';

import './product_card.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> _products;

  // Constructor with a shortcut to automatically assign a variable to a local variable.
  Products(this._products) {
    print('[Products Widget Constructor]');
  }

  Widget _buildProductList() {
    print('[Products Widget] _buildProductList()');
    Widget productCards;
    if (_products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, index) =>
            ProductCard(_products[index], index),
        itemCount: _products.length,
      );
    } else {
      productCards = Center(child: Text("No products found. Please add some."));
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return _buildProductList();
  }
}

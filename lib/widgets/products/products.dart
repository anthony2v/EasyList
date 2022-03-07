import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_card.dart';
import '../../models/product.dart';
import '../../scoped-models/main.dart';

class Products extends StatelessWidget {
  // Constructor with a shortcut to automatically assign a variable to a local variable.
  Products() {
    print('[Products Widget Constructor]');
  }

  Widget _buildProductList(MainModel model) {
    print('[Products Widget] _buildProductList()');
    Widget productCards;
    if (model.displayedProducts.length > 0) {
      List<Product> displayedProducts = model.displayedProducts;
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, index) =>
            ProductCard(displayedProducts[index]),
        itemCount: model.displayedProducts.length,
      );
    } else {
      productCards = Center(child: Text("No products found. Please add some."));
    }
    return RefreshIndicator(
        onRefresh: model.fetchProducts, child: productCards);
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return _buildProductList(model);
    });
  }
}

import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function deleteProduct;
  // Constructor with a shortcut to automatically assign a variable to a local variable.
  Products(this.products, {this.deleteProduct}) {
    print('[Products Widget Constructor]');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: Text('Details'),
                onPressed: () => Navigator.pushNamed<bool>(
                        context, '/product/' + index.toString())
                    .then((bool value) {
                  if (value) {
                    deleteProduct(index);
                  }
                }),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductList() {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
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

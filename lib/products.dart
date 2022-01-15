import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  // Constructor with a shortcut to automatically assign a variable to a local variable.
  Products(this.products) {
    print('[Products Widget Constructor]');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  products[index]['title'],
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oswald'),
                ),
                SizedBox(width: 8.0),
                Text(products[index]['price'].toString())
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                  child: Text('Details'),
                  onPressed: () => Navigator.pushNamed<bool>(
                      context, '/product/' + index.toString())),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductList() {
    print('[Products Widget] _buildProductList()');
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

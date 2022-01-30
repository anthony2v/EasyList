import 'package:flutter/material.dart';

import '../models/product.dart';
import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final Function _updateProduct;
  final Function _deleteProduct;
  final List<Product> _products;

  ProductListPage(this._products, this._updateProduct, this._deleteProduct);

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return ProductEditPage(
              updateProduct: _updateProduct,
              product: _products[index],
              productIndex: index,
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(_products[index].title),
            onDismissed: (DismissDirection direction) {
              // both dismiss directions should delete the product
              _deleteProduct(index);
            },
            background: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              color: Color(0xFFe53935),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage: AssetImage(_products[index].imagePath)),
                  title: Text(_products[index].title),
                  subtitle:
                      Text('\$${_products[index].price.toStringAsFixed(2)}'),
                  trailing: _buildEditButton(context, index),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: _products.length);
  }

  @override
  Widget build(BuildContext context) {
    if (_products.isEmpty)
      return Center(child: Text("No products found. Please add some."));
    return _buildProductList();
  }
}

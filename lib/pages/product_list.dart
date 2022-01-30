import 'package:flutter/material.dart';

import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final Function _updateProduct;
  final List<Map<String, dynamic>> _products;

  ProductListPage(this._products, this._updateProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                    backgroundImage: AssetImage(_products[index]['image'])),
                title: Text(_products[index]['title']),
                subtitle:
                    Text('\$${_products[index]['price'].toStringAsFixed(2)}'),
                trailing: IconButton(
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
                ),
              ),
              Divider(),
            ],
          );
        },
        itemCount: _products.length);
  }
}

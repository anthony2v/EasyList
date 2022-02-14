import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_edit.dart';
import '../scoped-models/products.dart';
import '../models/product.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage();

  Widget _buildEditButton(BuildContext context, Product product, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return ProductEditPage(
              product: product,
              productIndex: index,
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductList(ProductsModel model) {
    List<Product> products = model.products;
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(products[index].title),
            onDismissed: (DismissDirection direction) {
              // both dismiss directions should delete the product
              model.deleteProduct(index);
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
                      backgroundImage: AssetImage(products[index].imagePath)),
                  title: Text(products[index].title),
                  subtitle:
                      Text('\$${products[index].price.toStringAsFixed(2)}'),
                  trailing: _buildEditButton(context, products[index], index),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: products.length);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      if (model.size == 0)
        return Center(child: Text("No products found. Please add some."));
      return _buildProductList(model);
    });
  }
}

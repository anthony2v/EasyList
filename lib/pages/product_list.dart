import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_edit.dart';
import '../scoped-models/main.dart';
import '../models/product.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage();

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => ProductEditPage(),
          ),
        );
      },
    );
  }

  Widget _buildProductList(MainModel model) {
    List<Product> products = model.displayedProducts;
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(products[index].title),
            onDismissed: (DismissDirection direction) {
              // both dismiss directions should delete the product
              model.selectProduct(index);
              model.deleteProduct();
            },
            background: Container(
              padding: EdgeInsets.only(left: 250, right: 10),
              color: Color(0xFFe53935),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(products[index].imagePath)),
                  title: Text(products[index].title),
                  subtitle:
                      Text('\$${products[index].price.toStringAsFixed(2)}'),
                  trailing: _buildEditButton(context, index, model),
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
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      if (model.size == 0)
        return Center(child: Text("No products found. Please add some."));
      return _buildProductList(model);
    });
  }
}

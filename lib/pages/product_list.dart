import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_edit.dart';
import '../scoped-models/main.dart';
import '../models/product.dart';

class ProductListPage extends StatefulWidget {
  final MainModel _model;

  ProductListPage(this._model);

  @override
  State<StatefulWidget> createState() {
    return _ProductListPageState();
  }
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  initState() {
    widget._model.fetchProducts();
    super.initState();
  }

  Widget _buildEditButton(BuildContext context, String id, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(id);
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (BuildContext context) => ProductEditPage(),
              ),
            )
            .then((_) => model.selectProduct(null));
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
              model.selectProduct(products[index].id);
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
                  trailing:
                      _buildEditButton(context, products[index].id, model),
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

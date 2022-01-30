import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/products/products.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> _products;

  ProductsPage(this._products);

  Widget _buildSideDrawer(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text('Choose', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: _buildSideDrawer(context)),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('EasyList', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite),
            color: Colors.white,
          )
        ],
      ),
      body: Products(_products),
    );
  }
}

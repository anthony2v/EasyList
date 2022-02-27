import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../scoped-models/products.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage();

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
          ScopedModelDescendant<ProductsModel>(
            builder: (BuildContext context, Widget child, ProductsModel model) {
              return IconButton(
                onPressed: () => model.toggleDisplayMode(),
                icon: Icon(model.displayFavoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Colors.white,
              );
            },
          ),
        ],
      ),
      body: Products(),
    );
  }
}

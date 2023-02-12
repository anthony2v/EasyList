import 'package:first_app/scoped-models/main.dart';
import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';

class ProductsAdminPage extends StatelessWidget {
  final MainModel _model;

  ProductsAdminPage(this._model);

  Widget _buildSideDrawer(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text('Choose', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('All Products'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/products');
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(child: _buildSideDrawer(context)),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('Manage Products', style: TextStyle(color: Colors.white)),
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
            tabs: <Widget>[
              Tab(
                text: 'Create Product',
                icon: Icon(Icons.create),
              ),
              Tab(
                text: 'My Products',
                icon: Icon(Icons.list),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[ProductEditPage(), ProductListPage(_model)],
        ),
      ),
    );
  }
}

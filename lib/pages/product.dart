import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final Product _product;

  ProductPage(this._product);

  Widget _buildAddressPriceRow(String productAddress, double productPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(productAddress, style: TextStyle(color: Colors.grey)),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text('\$${productPrice.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.grey))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(_product.title, style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(_product.imagePath),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TitleDefault(_product.title),
          ),
          _buildAddressPriceRow(_product.address, _product.price),
          SizedBox(height: 5.0),
          Text(_product.description),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped-models/main.dart';
import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Product product = model.selectedProduct;
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(product.title, style: TextStyle(color: Colors.white)),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(product.imagePath),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TitleDefault(product.title),
              ),
              _buildAddressPriceRow(product.address, product.price),
              SizedBox(height: 5.0),
              Text(product.description),
            ],
          ),
        );
      },
    );
  }
}

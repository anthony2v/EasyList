import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './address_tag.dart';
import './price_tag.dart';
import '../../models/product.dart';
import '../ui_elements/title_default.dart';
import '../../scoped-models/products.dart';

class ProductCard extends StatelessWidget {
  final Product _product;
  final int _productIndex;

  ProductCard(this._product, this._productIndex);

  void _deleteProduct(bool confirm) {
    print(confirm);
  }

  Widget _buildTitlePriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleDefault(_product.title),
        SizedBox(width: 8.0),
        PriceTag(_product.price.toStringAsFixed(2)),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
            color: Theme.of(context).colorScheme.secondaryVariant,
            icon: Icon(Icons.info),
            onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + _productIndex.toString())
                .then(_deleteProduct)),
        ScopedModelDescendant<ProductsModel>(
            builder: (BuildContext context, Widget child, ProductsModel model) {
          return IconButton(
            color: Colors.red,
            onPressed: () {
              model.selectProduct(_productIndex);
              model.toggleProductFavoriteFlag();
            },
            icon: Icon(model.displayedProducts[_productIndex].isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(_product.imagePath),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: _buildTitlePriceRow()),
          AddressTag(_product.address),
          _buildActionButtons(
            context,
          ),
        ],
      ),
    );
  }
}

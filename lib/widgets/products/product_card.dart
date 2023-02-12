import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './address_tag.dart';
import './price_tag.dart';
import '../../models/product.dart';
import '../ui_elements/title_default.dart';
import '../../scoped-models/main.dart';

class ProductCard extends StatelessWidget {
  final Product _product;

  ProductCard(this._product);

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
            color: Theme.of(context).colorScheme.secondaryContainer,
            icon: Icon(Icons.info),
            onPressed: () =>
                Navigator.pushNamed<bool>(context, '/product/' + _product.id)),
        ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          return IconButton(
            color: Colors.red,
            onPressed: () {
              model.selectProduct(_product.id);
              model.toggleProductFavoriteFlag();
            },
            icon: Icon(
                _product.isFavorite ? Icons.favorite : Icons.favorite_border),
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
          CachedNetworkImage(
              imageUrl: _product.imagePath,
              placeholder: (context, url) => const CircularProgressIndicator()),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: _buildTitlePriceRow()),
          AddressTag(_product.address),
          Text(_product.userEmail),
          _buildActionButtons(
            context,
          ),
        ],
      ),
    );
  }
}

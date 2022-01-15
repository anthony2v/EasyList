import 'package:flutter/material.dart';

import './address_tag.dart';
import './price_tag.dart';
import '../ui_elements/title_default.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> _product;
  final int _productIndex;
  final bool _isFavorite = false;

  ProductCard(this._product, this._productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(_product['image']),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleDefault(_product['title']),
                SizedBox(width: 8.0),
                PriceTag(_product['price'].toString()),
              ],
            ),
          ),
          AddressTag(_product['address']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  icon: Icon(Icons.info),
                  onPressed: () => Navigator.pushNamed<bool>(
                      context, '/product/' + _productIndex.toString())),
              IconButton(
                  color: Colors.red,
                  onPressed: () {
                    print('Product favorited');
                    // TODO turn into stateful widget and flip _isFavorite
                  },
                  icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border))
            ],
          )
        ],
      ),
    );
  }
}

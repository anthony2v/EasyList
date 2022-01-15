import 'package:flutter/material.dart';
import 'package:first_app/widgets/products/price_tag.dart';

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
                Text(
                  _product['title'],
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Oswald'),
                ),
                SizedBox(width: 8.0),
                PriceTag(_product['price'].toString()),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text('Union Square, San Francisco'),
          ),
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

import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String _price;

  PriceTag(this._price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(6.0)),
      child: Text(
        '\$$_price',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

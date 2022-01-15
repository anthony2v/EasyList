import 'package:flutter/material.dart';

import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> _product;

  ProductPage(this._product);

  _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('This action cannot be undone!'),
          actions: <Widget>[
            TextButton(
              child: Text('DISCARD'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('CONTINUE'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddressPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_product['address'].toString(),
            style: TextStyle(color: Colors.grey)),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text('\$${_product['price'].toStringAsFixed(2)}',
            style: TextStyle(color: Colors.grey))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(_product['title'], style: TextStyle(color: Colors.white)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(_product['image']),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TitleDefault(_product['title']),
            ),
            _buildAddressPriceRow(),
            SizedBox(height: 5.0),
            Text(_product['description']),
            Container(
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text('DELETE', style: TextStyle(color: Colors.white)),
                onPressed: () => _showWarningDialog(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

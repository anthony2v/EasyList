import 'package:flutter/material.dart';
import 'package:first_app/widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final String _title;
  final String _imageUrl;

  ProductPage(this._title, this._imageUrl);

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
          title: Text(_title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(_imageUrl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TitleDefault(_title),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.secondaryVariant),
                ),
                child: Text('DELETE'),
                onPressed: () => _showWarningDialog(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

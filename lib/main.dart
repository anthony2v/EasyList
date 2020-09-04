/* Packt Learn Flutter and Dart to Build iOS and Android Apps */
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'pages/products_admin.dart';
import 'pages/products.dart';
import 'pages/product.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, String>> _products = [];
  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
    print(_products);
  }

  void _deleteProduct(int index) {
    setState(() {
      print('delete item at ' + index.toString());
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // MaterialApp is a descendant of Widget
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        accentColor: Colors.deepOrange,
      ),
      //home: AuthPage(), // Redundant, copy of '/': (BuildContext context) => ProductsPage(), in routes.
      routes: {
        '/': (BuildContext context) =>
            ProductsPage(_products, _addProduct, _deleteProduct),
        '/admin': (BuildContext context) => ProductsAdminPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          print(index);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
                _products[index]['title'], _products[index]['image']),
          );
        }
        return null;
      },
    );
  }
}

/* Packt Learn Flutter and Dart to Build iOS and Android Apps */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:flutter/rendering.dart';

import './pages/auth.dart';
import './pages/products_admin.dart';
import './pages/products.dart';
import './pages/product.dart';
import './scoped-models/main.dart';

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
  @override
  Widget build(BuildContext context) {
    final MainModel mainModel = MainModel();
    // MaterialApp is a descendant of Widget
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
          fontFamily: 'Oswald',
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
              .copyWith(
                  secondary: Colors.deepOrangeAccent,
                  secondaryVariant: Colors.purpleAccent),
        ),
        //home: AuthPage(), // Redundant, copy of '/': (BuildContext context) => ProductsPage(), in routes.
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/admin': (BuildContext context) => ProductsAdminPage(mainModel),
          '/products': (BuildContext context) => ProductsPage(mainModel),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            final int index = int.parse(pathElements[2]);
            print('[Main] build(): index: ');
            print(index);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(index),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(mainModel));
        },
      ),
    );
  }
}

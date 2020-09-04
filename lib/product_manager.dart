import 'package:flutter/material.dart';

import './products.dart';

import './product_control.dart';

class ProductManager extends StatefulWidget {
  final Map<String, String> startingProduct;

  ProductManager({this.startingProduct}) {
    print('[Product Manager Widget] constructor');
  }

  @override
  State<StatefulWidget> createState() {
    print('[Product Manager Widget] createState()');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String, String>> _products = [];

  @override
  initState() {
    print('[Product Manager Widget] initState()');
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('[Product Manager Widget] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
      print(_products);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[Product Manager Widget] build()');
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5.0),
          child: ProductControl(_addProduct),
        ),
        Expanded(child: Products(_products, deleteProduct: _deleteProduct))
      ],
    );
  }
}

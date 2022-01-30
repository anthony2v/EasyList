import 'package:flutter/material.dart';

class Product {
  final String address;
  final String description;
  String imagePath;
  double price;
  String title;

  Product(
      {@required this.address,
      @required this.description,
      @required this.imagePath,
      @required this.price,
      @required this.title});
}

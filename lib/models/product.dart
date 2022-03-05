import 'package:flutter/material.dart';

class Product {
  final String id;
  final String address;
  final String description;
  String imagePath;
  bool isFavorite;
  double price;
  String title;
  String userEmail;
  String userID;

  Product(
      {@required this.id,
      @required this.address,
      @required this.description,
      @required this.imagePath,
      @required this.price,
      @required this.title,
      @required this.userEmail,
      @required this.userID,
      this.isFavorite = false});
}

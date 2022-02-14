import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped-models/products.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _productData = {
    'title': '',
    'description': '',
    'price': 0.0,
    'image': 'assets/food.jpg',
    'address': 'Union Square, San Francisco'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      initialValue: product == null ? '' : product.title,
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be at least 5 characters long.';
        }
        return null;
      },
      onSaved: (String value) {
        _productData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      initialValue: product == null ? '' : product.description,
      maxLines: 4,
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Description is required and should be at least 10 characters long.';
        }
        return null;
      },
      onSaved: (String value) {
        _productData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Price'),
      initialValue: product == null ? '' : product.price.toStringAsFixed(2),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be a number.';
        }
        return null;
      },
      onSaved: (String value) {
        _productData['price'] = double.parse(value);
      },
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return ElevatedButton(
          onPressed: () => _submitForm(model.addProduct, model.updateProduct,
              model.selectedProductIndex),
          child: Text(
            'Save',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(height: 5.0),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(Function addProduct, Function updateProduct,
      [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Product product = new Product(
        address: _productData['address'],
        description: _productData['description'],
        imagePath: _productData['image'],
        price: _productData['price'],
        title: _productData['title']);
    if (selectedProductIndex == null)
      addProduct(product);
    else
      updateProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(color: Colors.white),
                  title: Text(
                    'Edit Product',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: pageContent);
      },
    );
  }
}

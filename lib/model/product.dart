import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Product {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,

  });

  Product.withoutId({
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
  });

  @override
  String toString() {
    return 'Product'
        '{id: $id,'
        ' title: $title,'
        ' description: $description,'
        ' price: $price,'
        ' imageUrl: $imageUrl,'
        '}';
  }
}

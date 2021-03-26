import 'package:flutter/foundation.dart';

class CartModel {
  String id;
  String productId;
  String title;
  String imageUrl;
  String description;
  int quantity;
  double price;

  CartModel({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.quantity,
    @required this.price,
  });

  CartModel.withoutId({
    @required this.productId,
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.quantity,
    @required this.price,
  });
}

import 'package:flutter/foundation.dart';
import 'package:mercado/model/cart_model.dart';

class OrderModel {
  String id;
  double amount;
  DateTime dateTime;
  List<CartModel> products;

  OrderModel({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
    @required this.products,
  });

  OrderModel.without({
    @required this.amount,
    @required this.dateTime,
    @required this.products,
  });
}

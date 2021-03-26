import 'package:flutter/foundation.dart';

class FavouriteModel {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  String productId;

  FavouriteModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.productId,
  });

  FavouriteModel.withoutId({
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.productId,
  });

  @override
  String toString() =>
      '{id: $id,'
          ' title: $title,'
          ' description: $description,'
          ' price: $price,'
          ' imageUrl: $imageUrl,'
          ' productId: $productId,'
          '}';
}

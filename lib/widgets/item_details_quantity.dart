import 'package:flutter/material.dart';
import 'cart_quantity_button.dart';
import 'header_text_5.dart';

class ItemDetailsQuantity extends StatelessWidget {
  final Function onPressAdd;
  final Function onPressRemove;
  final int quantity;
  final double price;

  ItemDetailsQuantity({
    @required this.quantity,
    @required this.onPressAdd,
    @required this.onPressRemove,
    @required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Row(
        children: [
          CartQuantityButton(icon: Icons.remove, onPress: onPressRemove),
          SizedBox(
            width: 8.0,
          ),
          Header5(
            title: '$quantity',
          ),
          SizedBox(
            width: 8.0,
          ),
          CartQuantityButton(icon: Icons.add, onPress: onPressAdd),
          Spacer(),
          Header5(
            title: '\$${price.toStringAsFixed(2)}',
            size: 18.0,
          ),
        ],
      ),
    );
  }
}

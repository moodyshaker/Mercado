import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mercado/model/order_model.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

import 'confirm_dialog.dart';

class OrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (ctx, vm, ch) => ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.all(
              12.0,
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            vm.isDarkMode ? Colors.white : Colors.black,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
          ),
        ),
        onPressed: () {
          if (vm.carts.length > 0) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => ConfirmDialog(
                title: 'Order',
                content: 'Order Placed Success',
                onConfirmTitle: 'OK',
                onCancelTitle: 'Cancel',
                onConfirm: () {
                  Navigator.pop(context);
                  vm.addOrder(
                    OrderModel.without(
                      amount: vm.cartTotalAmount(),
                      dateTime: DateTime.now(),
                      products: vm.carts,
                    ),
                  );
                  vm.deleteAllCarts();
                  vm.changeSelectedItem(0, 'Shop');
                },
                onCancel: () {
                  Navigator.pop(context);
                },
              ),
            );
          } else {
            Fluttertoast.showToast(msg: 'There is no orders in your cart');
          }
        },
        child: Text(
          'Order Now',
          style: Theme.of(context).appBarTheme.textTheme.headline5.copyWith(
                color: vm.isDarkMode ? Colors.black : Colors.white,
              ),
        ),
      ),
    );
  }
}

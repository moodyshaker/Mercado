import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mercado/model/cart_model.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/confirm_dialog.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final CartModel cart;

  CartItem({
    @required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (ctx, vm, ch) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 8.0,
        margin: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Dismissible(
            background: Center(
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                ),
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
            key: ValueKey(cart.id),
            confirmDismiss: (_) async {
              return await showDialog(
                context: context,
                builder: (ctx) => ConfirmDialog(
                  title: 'Delete',
                  content: 'Do you want to delete this item',
                  onConfirm: () {
                    Navigator.pop(ctx);
                    vm.deleteCart(cart.id, false);
                    Fluttertoast.showToast(msg: 'Cart deleted successfully');
                  },
                  onCancel: () {
                    Navigator.pop(ctx);
                  },
                  onConfirmTitle: 'Delete',
                  onCancelTitle: 'Cancel',
                ),
              );
            },
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
              title: Text(
                cart.title,
                style:
                    Theme.of(context).appBarTheme.textTheme.headline3.copyWith(
                          fontSize: 18.0,
                        ),
              ),
              leading: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: cart.imageUrl.contains('http')
                      ? Image.network(
                          cart.imageUrl,
                          width: 60.0,
                          height: 100.0,
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          File(cart.imageUrl),
                          width: 60.0,
                          height: 100.0,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              subtitle: Text(
                '\$${cart.price}',
                style:
                    Theme.of(context).appBarTheme.textTheme.headline5.copyWith(
                          fontSize: 18.0,
                        ),
              ),
              trailing: Text(
                'X${cart.quantity}',
                style:
                    Theme.of(context).appBarTheme.textTheme.headline5.copyWith(
                          fontSize: 19.0,
                        ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

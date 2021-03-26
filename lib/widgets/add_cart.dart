import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

import 'header_text_5.dart';

class AddCart extends StatelessWidget {
  final Function onCartPressed;
  final bool isCart;

  AddCart({
    @required this.onCartPressed,
    @required this.isCart,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => GestureDetector(
        onTap: onCartPressed,
        child: Container(
          width: size.width * 0.5,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: vm.isDarkMode ? Colors.white : Colors.black,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                color: vm.isDarkMode ? Colors.black : Colors.white,
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Header5(
                title: isCart ? 'Added To Cart' : 'Add To Cart',
                color: vm.isDarkMode ? Colors.black : Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

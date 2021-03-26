import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

class CartQuantityButton extends StatelessWidget {
  final IconData icon;
  final Function onPress;

  CartQuantityButton({
    @required this.icon,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (ctx, vm, ch) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: vm.isDarkMode ? Colors.white : Colors.black,
        ),
        height: 30.0,
        width: 30.0,
        child: IconButton(
          padding: EdgeInsets.all(0.0),
          onPressed: onPress,
          icon: Icon(
            icon,
            color: vm.isDarkMode ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}

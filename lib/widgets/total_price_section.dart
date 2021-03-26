import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

class TotalPriceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (ctx, vm, ch) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total',
            style: Theme.of(context).appBarTheme.textTheme.headline5.copyWith(
                  color: vm.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 22.0,
                ),
          ),
          SizedBox(
            width: 6.0,
          ),
          Chip(
            backgroundColor: vm.isDarkMode ? Colors.white : Colors.black,
            label: Text(
              '${vm.cartTotalAmount().toStringAsFixed(2)}',
              style: Theme.of(context).appBarTheme.textTheme.headline5.copyWith(
                    color: vm.isDarkMode ? Colors.black : Colors.white,
                    fontSize: 18.0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

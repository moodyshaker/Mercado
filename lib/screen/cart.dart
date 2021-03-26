import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/cart_item.dart';
import 'package:mercado/widgets/order_button.dart';
import 'package:mercado/widgets/total_price_section.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  static const String id = 'CART';

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  GeneralProvider _vm;

  @override
  void initState() {
    super.initState();
    _vm = Provider.of<GeneralProvider>(context, listen: false);
    _vm.getCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => vm.cartLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : vm.isCartEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 40.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'There is no Items in Cart',
                          style:
                              Theme.of(context).appBarTheme.textTheme.headline5,
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (ctx, i) => CartItem(
                            cart: vm.carts[i],
                          ),
                          itemCount: vm.carts.length,
                        ),
                      ),
                      Divider(
                        thickness: 2.0,
                        color: vm.isDarkMode ? Colors.white : Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TotalPriceSection(),
                            OrderButton(),
                          ],
                        ),
                      )
                    ],
                  ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/order_item.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  static const String id = 'ORDER';

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  GeneralProvider _vm;

  @override
  void initState() {
    super.initState();
    _vm = Provider.of<GeneralProvider>(context, listen: false);
    _vm.getOrders();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => vm.orderLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : vm.isOrderEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.credit_card_outlined,
              size: 40.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'There is no Items in Order',
              style:
              Theme.of(context).appBarTheme.textTheme.headline5,
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: vm.orders.length,
        itemBuilder: (context, i) => OrderItem(orderModel: vm.orders[i]),
      ),
    );
  }
}

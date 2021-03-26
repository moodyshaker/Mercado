import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mercado/model/order_model.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatefulWidget {
  final OrderModel orderModel;

  OrderItem({
    @required this.orderModel,
  });

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final GeneralProvider vm = Provider.of<GeneralProvider>(context, listen: false);
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 8.0,
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${widget.orderModel.amount}',
              style: Theme.of(context).appBarTheme.textTheme.headline5.copyWith(
                    color: vm.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18.0,
                  ),
            ),
            subtitle: Text(
              '${DateFormat('dd MM yyyy hh:mm').format(widget.orderModel.dateTime)}',
              style: TextStyle(
                  fontSize: 14.7,
                  color: vm.isDarkMode ? Colors.grey : Colors.black54),
            ),
            trailing: IconButton(
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: vm.isDarkMode ? Colors.grey : Colors.black54,
              ),
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
            ),
          ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _isExpanded ? 75.0 * widget.orderModel.products.length : 0.0,
              child: ListView.builder(
                itemCount: widget.orderModel.products.length,
                itemBuilder: (context, i) => ListTile(
                  title: Text(
                    widget.orderModel.products[i].title,
                    style: Theme.of(context)
                        .appBarTheme
                        .textTheme
                        .headline5
                        .copyWith(
                          color: vm.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 16.0,
                        ),
                  ),
                  subtitle: Text(
                    '\$${widget.orderModel.products[i].price}',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: vm.isDarkMode ? Colors.grey : Colors.black54),
                  ),
                  trailing: Text(
                    'X${widget.orderModel.products[i].quantity}',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: vm.isDarkMode ? Colors.grey : Colors.black54),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: widget.orderModel.products[i].imageUrl.contains('http') ? NetworkImage(
                      widget.orderModel.products[i].imageUrl,
                    ):FileImage(File(widget.orderModel.products[i].imageUrl)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

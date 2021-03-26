import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mercado/model/cart_model.dart';
import 'package:mercado/model/checked_model.dart';
import 'package:mercado/model/product.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/add_cart.dart';
import 'package:mercado/widgets/item_details_quantity.dart';
import 'package:provider/provider.dart';

import 'header_text_5.dart';
import 'item_options.dart';

class ItemInformation extends StatefulWidget {
  final Product product;

  ItemInformation({
    @required this.product,
  });

  @override
  _ItemInformationState createState() => _ItemInformationState();
}

class _ItemInformationState extends State<ItemInformation> {
  bool _cart = false;
  GeneralProvider _vm;

  @override
  void initState() {
    super.initState();
    _vm = Provider.of<GeneralProvider>(context, listen: false);
    _cart = _vm.isCart(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header5(
                title: widget.product.title,
                size: 24.0,
              ),
              Header5(
                title: '\$${widget.product.price}',
                size: 18.0,
              ),
            ],
          ),
          Text(
            widget.product.description,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: vm.isDarkMode ? Colors.white54 : Colors.black87,
              fontSize: 17.0,
            ),
          ),
          ItemOptions(
            optionTitle: 'Color',
            onItemClicked: (int i, CheckedModel item) {
              vm.setSelectedColor(i);
              vm.setColor(item);
            },
            optionList: [
              CheckedModel(
                title: 'Brown',
                color: Colors.brown,
              ),
              CheckedModel(
                title: 'Black',
                color: Colors.black,
              ),
              CheckedModel(
                title: 'Cyan',
                color: Colors.cyan,
              ),
              CheckedModel(
                title: 'Amber',
                color: Colors.amber,
              ),
              CheckedModel(
                title: 'Grey',
                color: Colors.grey,
              )
            ],
            isColor: true,
            selectedOption: vm.selectedColor,
          ),
          ItemOptions(
            optionTitle: 'Size',
            onItemClicked: (int i, CheckedModel item) {
              vm.setSelectedSize(i);
              vm.setSize(item);
            },
            optionList: [
              CheckedModel(
                title: 'S',
              ),
              CheckedModel(
                title: 'M',
              ),
              CheckedModel(
                title: 'L',
              ),
            ],
            isColor: false,
            selectedOption: vm.selectedSize,
          ),
          ItemDetailsQuantity(
            quantity: vm.quantity,
            price: vm.quantity * widget.product.price,
            onPressAdd: () {
              vm.addQuantity();
            },
            onPressRemove: () {
              vm.removeQuantity();
            },
          ),
          AddCart(
            isCart: _cart,
            onCartPressed: () {
              if (_cart) {
                vm.deleteCart(widget.product.id, true);
                Fluttertoast.showToast(msg: 'Item deleted from Cart');
              } else {
                vm.addCart(
                  CartModel.withoutId(
                    title: widget.product.title,
                    imageUrl: widget.product.imageUrl,
                    quantity: vm.quantity,
                    price: widget.product.price,
                    description: widget.product.description,
                    productId: widget.product.id,
                  ),
                );
                Fluttertoast.showToast(msg: 'Item added to Cart');
              }
              vm.resetQuantity();
              setState(() {
                _cart = !_cart;
              });
            },
          ),
        ],
      ),
    );
  }
}

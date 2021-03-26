import 'package:flutter/material.dart';
import 'package:mercado/model/drawer_model.dart';
import 'package:mercado/view_model/general_provider.dart';

import 'shop_drawer.dart';

class ShopDrawerImp extends StatelessWidget {
  final GeneralProvider vm;

  ShopDrawerImp({
    @required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return ShopDrawer(
      names: const [
        const DrawerModel(icon: Icons.shop, title: 'Shop'),
        const DrawerModel(icon: Icons.favorite, title: 'Favourite'),
        const DrawerModel(icon: Icons.shopping_cart, title: 'Cart'),
        const DrawerModel(icon: Icons.credit_card_outlined, title: 'Order'),
        const DrawerModel(icon: Icons.edit, title: 'Manage Products'),
        const DrawerModel(icon: Icons.favorite, title: 'Dark Mode'),
      ],
      selectedItem: vm.selectedItem,
      onItemPressed: (int index, String title) {
        vm.changeSelectedItem(index, title);
        Navigator.pop(context);
      },
    );
  }
}

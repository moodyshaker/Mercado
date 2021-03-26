import 'package:flutter/material.dart';
import 'package:mercado/model/drawer_model.dart';
import 'package:mercado/screen/cart.dart';
import 'package:mercado/screen/favourite.dart';

class DropDown extends StatelessWidget {
  final List<DrawerModel> model = const[
    DrawerModel(icon: Icons.favorite, title: 'Favourite'),
    DrawerModel(icon: Icons.shopping_cart, title: 'Cart'),
  ];
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<DrawerModel>(
      onSelected: (DrawerModel model){
        model.title == 'Cart' ?
        Navigator.pushNamed(context, Cart.id):
        Navigator.pushNamed(context, Favourite.id);
      },
      itemBuilder: (context) => model
          .map(
            (e) => PopupMenuItem<DrawerModel>(
          value: e,
          child: ListTile(
            title: Text(e.title),
            leading: Icon(e.icon),
          ),
        ),
      )
          .toList(),
    );
  }
}

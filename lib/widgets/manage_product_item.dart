import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mercado/model/product.dart';
import 'package:mercado/screen/add_product.dart';
import 'package:mercado/screen/item_details.dart';
import 'package:mercado/services/auth.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

class ManageProductItem extends StatelessWidget {
  final Product product;

  ManageProductItem({
    @required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            ItemDetails.id,
            arguments: product,
          );
        },
        title: Text(
          product.title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: CircleAvatar(
          backgroundImage: product.imageUrl.contains('http')
              ? NetworkImage(product.imageUrl)
              : FileImage(
                  File(product.imageUrl),
                ),
        ),
        trailing: Consumer<GeneralProvider>(
          builder: (ctx, vm, ch) => Wrap(
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: vm.isDarkMode ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AddProduct.id,
                      arguments: product);
                },
              ),
              SizedBox(
                width: 8.0,
              ),
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: vm.isDarkMode ? Colors.red[900] : Colors.red,
                  ),
                  onPressed: () async {
                    String r = await vm.deleteProduct(product);
                    if (r != Auth.success) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'There is an error with your connection',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/manage_product_item.dart';
import 'package:provider/provider.dart';

class ManageProducts extends StatefulWidget {
  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  GeneralProvider _vm;

  @override
  void initState() {
    super.initState();
    _vm = Provider.of<GeneralProvider>(context, listen: false);
    _vm.getUserProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (ctx, vm, ch) {
        return vm.productLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : vm.isProductsByUserEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 40.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'You did not add any products yet',
                          style:
                              Theme.of(context).appBarTheme.textTheme.headline5,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: vm.productsByUser.length,
                    itemBuilder: (ctx, i) => ManageProductItem(
                      product: vm.productsByUser[i],
                    ),
                  );
      },
    );
  }
}

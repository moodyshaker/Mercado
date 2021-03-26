import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/shop_grid_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Shop extends StatefulWidget {
  static const String id = 'SHOP';

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  GeneralProvider _vm;

  @override
  void initState() {
    super.initState();
    _vm = Provider.of<GeneralProvider>(context, listen: false);
    _vm.getCarts();
    _vm.getFavourites();
    _vm.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => vm.productLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : vm.isProductsEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_basket,
                        size: 40.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'There is no Products in Shop you can add new products from Manage Products',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).appBarTheme.textTheme.headline5,
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => _vm.clearProductList(),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 6.0,
                          ),
                          child: Text(
                            'The most popular clothes today',
                            style: Theme.of(context)
                                .appBarTheme
                                .textTheme
                                .headline5
                                .copyWith(
                                  fontSize: 35.0,
                                ),
                          ),
                        ),
                        StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(8.0),
                          crossAxisCount: 4,
                          itemCount: vm.products.length,
                          itemBuilder: (BuildContext context, int index) =>
                              ShopGridItem(
                            product: vm.products[index],
                          ),
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.count(
                                  2, !index.isEven ? 3 : 2.5),
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}

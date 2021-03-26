import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/favourite_grid_item.dart';
import 'package:provider/provider.dart';

class Favourite extends StatefulWidget {
  static const String id = 'FAVOURITE';

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  GeneralProvider _vm;

  @override
  void initState() {
    super.initState();
    _vm = Provider.of<GeneralProvider>(context, listen: false);
    _vm.getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => WillPopScope(
        onWillPop: () async {
          vm.changeSelectedItem(0, 'Shop');
          return false;
        },
        child: vm.favouriteLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : vm.isFavouriteEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_outline,
                      size: 40.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'There is no Items in Favourite',
                      style: Theme.of(context).appBarTheme.textTheme.headline5,
                    ),
                  ],
                ),
              )
            : StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(8.0),
                crossAxisCount: 4,
                itemCount: vm.favouriteProducts.length,
                itemBuilder: (BuildContext context, int index) =>
                    FavouriteGridItem(
                  favourite: vm.favouriteProducts[index],
                ),
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(2, !index.isEven ? 3 : 2.5),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
      ),
    );
  }
}

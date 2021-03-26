import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mercado/model/favourite_model.dart';
import 'package:mercado/model/product.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/item_info.dart';
import 'package:mercado/widgets/no_connection_view.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ItemDetails extends StatefulWidget {
  static const String id = 'ITEM_DETAILS';
  final String productId;

  ItemDetails({
    @required this.productId,
  });

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  bool _favourite = false;
  GeneralProvider _vm;
  Product _product;

  @override
  void initState() {
    super.initState();
    _vm = Provider.of<GeneralProvider>(context, listen: false);
    _product = _vm.getProductById(widget.productId);
    _favourite = _vm.isFavourite(widget.productId);
    _vm.initConnectivity();
  }

  @override
  void dispose() {
    _vm.disposeConnectivity();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              height: size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: _product.imageUrl.contains(
                    'http',
                  )
                      ? NetworkImage(
                          _product.imageUrl,
                        )
                      : FileImage(
                          File(
                            _product.imageUrl,
                          ),
                        ),
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(
                0.4,
              ),
              height: size.height * 0.5,
            ),
            // Container(
            //   margin: EdgeInsets.only(
            //     top: size.height * 0.368,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: List.generate(
            //       5,
            //       (index) => Container(
            //         margin: EdgeInsets.all(6.0),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(8.0),
            //           color: Colors.white,
            //         ),
            //         height: 10.0,
            //         width: 10.0,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        Consumer<GeneralProvider>(
          builder: (context, vm, child) => WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, _favourite);
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                leading: Transform.rotate(
                  angle: pi,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context, _favourite);
                    },
                    icon: Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
                actions: [
                  Container(
                    width: 56.0,
                    height: 56.0,
                    child: IconButton(
                      onPressed: () {
                        if (_favourite) {
                          vm.deleteFavourite(_product.id);
                          Fluttertoast.showToast(
                              msg: 'Item deleted from Favourite');
                        } else {
                          vm.setFavourite(
                            FavouriteModel.withoutId(
                              title: _product.title,
                              description: _product.description,
                              productId: _product.id,
                              imageUrl: _product.imageUrl,
                              price: _product.price,
                            ),
                          );
                          Fluttertoast.showToast(
                              msg: 'Item added to Favourite');
                        }
                        setState(() {
                          _favourite = !_favourite;
                        });
                      },
                      icon: Icon(
                        _favourite ? Icons.favorite : Icons.favorite_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
              body: vm.networkState == NetworkState.NO_CONNECTION
                  ? NoConnectionView()
                  : SizedBox(
                      height: size.height,
                      child: Consumer<GeneralProvider>(
                        builder: (context, vm, child) => Container(
                          margin: EdgeInsets.only(top: size.height * 0.3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            color: vm.isDarkMode ? Colors.black : Colors.white,
                          ),
                          padding: EdgeInsets.all(25.0),
                          child: ItemInformation(
                            product: _product,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mercado/model/favourite_model.dart';
import 'package:mercado/model/product.dart';
import 'package:mercado/screen/item_details.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/header_text_5.dart';
import 'package:provider/provider.dart';
import 'header_text_3.dart';

class ShopGridItem extends StatefulWidget {
  final Product product;

  ShopGridItem({
    @required this.product,
  });

  @override
  _ShopGridItemState createState() => _ShopGridItemState();
}

class _ShopGridItemState extends State<ShopGridItem> {
  bool _favourite = false;
  GeneralProvider _vm;

  @override
  void initState() {
    super.initState();
    _vm = Provider.of<GeneralProvider>(context, listen: false);
    setState(() {
      _favourite = _vm.isFavourite(widget.product.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool fav = await Navigator.pushNamed(
          context,
          ItemDetails.id,
          arguments: widget.product.id,
        );
        if (mounted) {
          setState(() {
            _favourite = fav;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 8.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: widget.product.imageUrl.contains('http')
                          ? Image.network(
                              widget.product.imageUrl,
                              fit: BoxFit.fill,
                            )
                          : Image.file(
                              File(
                                widget.product.imageUrl,
                              ),
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 20.0,
                    ),
                    child: Align(
                      child: CircleAvatar(
                        radius: 17.0,
                        backgroundColor: Theme.of(context).accentColor,
                        child: Consumer<GeneralProvider>(
                          builder: (context, vm, ch) => IconButton(
                            icon: ch,
                            onPressed: () async {
                              if (_favourite) {
                                vm.deleteFavourite(widget.product.id);
                                Fluttertoast.showToast(
                                    msg: 'Item deleted from Favourite');
                              } else {
                                vm.setFavourite(
                                  FavouriteModel.withoutId(
                                    title: widget.product.title,
                                    description: widget.product.description,
                                    price: widget.product.price,
                                    imageUrl: widget.product.imageUrl,
                                    productId: widget.product.id,
                                  ),
                                );
                                Fluttertoast.showToast(
                                    msg: 'Item added to Favourite');
                              }
                              setState(() {
                                _favourite = !_favourite;
                              });
                            },
                          ),
                          child: Icon(
                            _favourite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      alignment: Alignment.bottomRight,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            Header3(
              title: widget.product.title,
            ),
            const SizedBox(
              height: 6.0,
            ),
            Header5(
              title: '\$${widget.product.price}',
              size: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mercado/model/favourite_model.dart';
import 'package:mercado/screen/item_details.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

import 'header_text_3.dart';
import 'header_text_5.dart';

class FavouriteGridItem extends StatelessWidget {
  final FavouriteModel favourite;

  FavouriteGridItem({
    @required this.favourite,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => GestureDetector(
        onTap: () async {
          bool fav = await Navigator.pushNamed(
            context,
            ItemDetails.id,
            arguments: favourite.productId,
          );
          if (!fav) {
            vm.deleteFavourite(favourite.productId);
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
                        child: favourite.imageUrl.contains('http')
                            ? Image.network(
                                favourite.imageUrl,
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                File(
                                  favourite.imageUrl,
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
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              vm.deleteFavourite(favourite.productId);
                            },
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
                title: favourite.title,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Header5(
                title: '\$${favourite.price}',
                size: 18.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

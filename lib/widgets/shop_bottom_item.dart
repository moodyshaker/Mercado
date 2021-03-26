import 'package:flutter/material.dart';

class ShopItemBottom extends StatelessWidget {
  final String title;
  final IconData leftIcon;
  final IconData rightIcon;

  ShopItemBottom({
    @required this.title,
    @required this.leftIcon,
    @required this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.black87,
      leading: Icon(
        leftIcon,
        color: Theme.of(context).accentColor,
      ),
      trailing: Icon(
        rightIcon,
        color: Theme.of(context).accentColor,
      ),
      title: Text(
        'Red T-Shirt Red T-Shirt',
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}

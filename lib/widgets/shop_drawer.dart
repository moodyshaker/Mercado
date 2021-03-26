import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mercado/model/drawer_model.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

class ShopDrawer extends StatefulWidget {
  final List<DrawerModel> names;
  final Function onItemPressed;
  final int selectedItem;

  ShopDrawer({
    @required this.names,
    @required this.onItemPressed,
    @required this.selectedItem,
  });

  @override
  _ShopDrawerState createState() => _ShopDrawerState();
}

class _ShopDrawerState extends State<ShopDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer<GeneralProvider>(
            builder: (context, vm, child) => ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              child: Container(
                color: Colors.black,
                child: SafeArea(
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    tileColor: Theme.of(context).primaryColor,
                    trailing: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onTap: () => widget.onItemPressed(5, 'Settings'),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20.0,
                      child: CircleAvatar(
                        radius: 18.0,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: vm.isFirstTime
                            ? Icon(
                                Icons.account_circle,
                              )
                            : vm.getImageUrl.isEmpty
                                ? Text(
                                    '${vm.getName.split(' ')[0][0]}${vm.getName.split(' ')[1][0]}',
                                    style: Theme.of(context)
                                        .appBarTheme
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        vm.getImageUrl.contains('http')
                                            ? NetworkImage(
                                                vm.getImageUrl,
                                              )
                                            : FileImage(
                                                File(
                                                  vm.getImageUrl,
                                                ),
                                              ),
                                  ),
                      ),
                    ),
                    title: Text(
                      'Hello ${vm.getName.split(' ')[0]}',
                      style: Theme.of(context)
                          .appBarTheme
                          .textTheme
                          .headline6
                          .copyWith(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ...widget.names
              .map(
                (item) => Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: widget.names.indexOf(item) == widget.names.length - 1
                      ? Consumer<GeneralProvider>(
                          builder: (context, vm, child) => SwitchListTile(
                            value: vm.isDarkMode,
                            title: Text(
                              item.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                            ),
                            onChanged: (bool value) {
                              vm.setDarkModeState(value);
                              Navigator.pop(context);
                            },
                            activeColor: Theme.of(context).accentColor,
                          ),
                        )
                      : ListTile(
                          tileColor:
                              widget.names.indexOf(item) == widget.selectedItem
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                          title: Text(
                            item.title,
                            style: widget.names.indexOf(item) ==
                                    widget.selectedItem
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    )
                                : Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                          ),
                          trailing: item.title == 'Cart'
                              ? Consumer<GeneralProvider>(
                                  builder: (ctx, vm, ch) => CircleAvatar(
                                    radius: 15.0,
                                    backgroundColor: vm.isDarkMode ||
                                            widget.names.indexOf(item) ==
                                                widget.selectedItem
                                        ? Colors.white
                                        : Colors.black,
                                    child: Text(
                                      '${vm.carts.length}',
                                      // ${vm.carts.length}
                                      style: TextStyle(
                                        color: vm.isDarkMode ||
                                                widget.names.indexOf(item) ==
                                                    widget.selectedItem
                                            ? Colors.black
                                            : Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          leading: Icon(
                            item.icon,
                            color: widget.names.indexOf(item) ==
                                    widget.selectedItem
                                ? Colors.white
                                : Colors.black,
                          ),
                          onTap: () => widget.onItemPressed(
                              widget.names.indexOf(item), item.title),
                        ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}

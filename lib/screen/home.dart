import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mercado/constants.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/confirm_dialog.dart';
import 'package:mercado/widgets/header_text_5.dart';
import 'package:mercado/widgets/no_connection_view.dart';
import 'package:mercado/widgets/shop_drawer_imp.dart';
import 'package:provider/provider.dart';

import 'add_product.dart';

class Home extends StatefulWidget {
  static const String id = 'HOME';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  GeneralProvider _vm;

  @override
  void initState() {
    super.initState();
    _vm = Provider.of<GeneralProvider>(context, listen: false);
    _vm.initConnectivity();
  }

  @override
  void dispose() {
    _vm.disposeConnectivity();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => ConfirmDialog(
              title: 'Exit',
              content: 'Do you want to exit the app ?',
              onConfirm: () {
                SystemNavigator.pop();
              },
              onCancel: () {
                Navigator.pop(context);
              },
              onConfirmTitle: 'OK',
              onCancelTitle: 'Cancel',
            ),
          );
          return false;
        },
        child: Scaffold(
          floatingActionButton: vm.selectedItem == 4
              ? FloatingActionButton.extended(
                  backgroundColor: Theme.of(context).accentColor,
                  onPressed: () => Navigator.pushNamed(context, AddProduct.id),
                  label: Header5(
                    title: 'Add Product',
                    color: Colors.white,
                    size: 16.0,
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )
              : Container(),
          appBar: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            )),
            title: Text(
              vm.selectedTitle,
            ),
          ),
          drawer: ShopDrawerImp(
            vm: vm,
          ),
          body: vm.networkState == NetworkState.NO_CONNECTION
              ? NoConnectionView()
              : vm.currentWidget,
        ),
      ),
    );
  }
}

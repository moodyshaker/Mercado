import 'package:flutter/material.dart';
import 'package:mercado/screen/login.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

import 'fancy_button.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FancyButton(
            onPress: () async {
              await vm.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, Login.id, (route) => false);
              vm.changeSelectedItem(0, 'Shop');
            },
            title: 'Logout',
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

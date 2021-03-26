import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

import 'fancy_button.dart';
import 'update_username_dialog.dart';

class UpdatePasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<GeneralProvider>(
          builder: (context, vm, child) => FancyButton(
            onPress: () async {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                builder: (context) => SingleChildScrollView(
                  child: UpdateUsernameDialog(
                    isNewPassword: true,
                  ),
                ),
              );
            },
            title: 'Change password',
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

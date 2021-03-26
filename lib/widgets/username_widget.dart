import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/update_username_dialog.dart';
import 'package:provider/provider.dart';

import 'header_text_5.dart';

class UsernameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          vm.getName != null
              ? Header5(
                  title: vm.getName,
                )
              : Container(),
          SizedBox(
            width: 6.0,
          ),
          IconButton(
            onPressed: () {
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
                    isNewPassword: false,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.edit,
              size: 26.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

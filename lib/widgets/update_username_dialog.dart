import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mercado/constants.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/fancy_button.dart';
import 'package:provider/provider.dart';

import 'edit_text.dart';
import 'header_text_5.dart';

class UpdateUsernameDialog extends StatefulWidget {
  final bool isNewPassword;

  UpdateUsernameDialog({
    @required this.isNewPassword,
  });

  @override
  _EditUsernameBSDState createState() => _EditUsernameBSDState();
}

class _EditUsernameBSDState extends State<UpdateUsernameDialog> {
  bool _isFocus = false;
  GeneralProvider _vm;

  @override
  void initState() {
    super.initState();
    _vm = Provider.of<GeneralProvider>(context, listen: false);
    _vm.initSettingsControllersAndFocus();
    _vm.updateSettingsFocus.addListener(() {
      setState(() {
        _isFocus = _vm.updateSettingsFocus.hasFocus;
      });
    });

    _vm.updateSettingsController.addListener(() {
      setState(() {
        if (widget.isNewPassword) {
          _vm.updateSettingsController.text.length < 6
              ? _vm.setUpdateSettingsErrorMsg(passwordErrorMsg)
              : _vm.setUpdateSettingsErrorMsg(null);
        } else {
          _vm.updateSettingsController.text.length < 5
              ? _vm.setUpdateSettingsErrorMsg(fullNameErrorMsg)
              : _vm.setUpdateSettingsErrorMsg(null);
        }
      });
    });
  }

  @override
  void dispose() {
    _vm.disposeSettingsControllersAndFocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 12.0,
          right: 12.0,
          left: 12.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 12.0),
      child: Consumer<GeneralProvider>(
        builder: (context, vm, child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Header5(
                  title: widget.isNewPassword
                      ? 'Enter your new password'
                      : 'Enter your new username',
                  size: 24,
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            EditText(
              isPassword: widget.isNewPassword ? true : false,
              isFocused: _isFocus,
              type: widget.isNewPassword
                  ? TextInputType.visiblePassword
                  : TextInputType.text,
              errorMsg: vm.updateSettingsErrorMsg,
              focusNode: vm.updateSettingsFocus,
              controller: vm.updateSettingsController,
              labelText: widget.isNewPassword
                  ? 'Enter your new password'
                  : 'Enter your full name',
            ),
            SizedBox(
              height: 8.0,
            ),
            FancyButton(
              textColor: Colors.white,
              color: Theme.of(context).accentColor,
              onPress: () async {
                if (widget.isNewPassword) {
                  if (_vm.updateSettingsController.text.length < 6) {
                    _vm.setUpdateSettingsErrorMsg(passwordErrorMsg);
                  } else {
                    Navigator.pop(context);
                    vm.setLoading(true);
                    await vm.updatePassword(vm.updateSettingsController.text);
                    Fluttertoast.showToast(
                        msg: 'your password changed successfully');
                    vm.setLoading(false);
                  }
                } else {
                  if (_vm.updateSettingsController.text.length < 5) {
                    _vm.setUpdateSettingsErrorMsg(fullNameErrorMsg);
                  } else {
                    Navigator.pop(context);
                    vm.setLoading(true);
                    await vm.updateProfile(
                        username: vm.updateSettingsController.text);
                    Fluttertoast.showToast(
                        msg: 'your username changed successfully');
                    vm.setLoading(false);
                  }
                }
              },
              title:
                  widget.isNewPassword ? 'Update Password' : 'Update Username',
            ),
          ],
        ),
      ),
    );
  }
}

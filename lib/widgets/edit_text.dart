import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';

class EditText extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType type;
  final TextCapitalization capitalization;
  final FocusNode focusNode;
  final bool isFocused;
  final String errorMsg;
  final bool isPassword;

  EditText({
    this.labelText,
    this.controller,
    this.type,
    this.capitalization,
    this.focusNode,
    this.isFocused,
    this.errorMsg,
    this.isPassword,
  });

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => TextField(
        focusNode: widget.focusNode,
        keyboardType: widget.type,
        textCapitalization: widget.capitalization != null
            ? widget.capitalization
            : TextCapitalization.none,
        controller: widget.controller,
        obscureText: widget.isPassword ? _isObscure : false,
        decoration: InputDecoration(
          labelText: widget.labelText,
          focusColor: Theme.of(context).primaryColor,
          errorText: widget.errorMsg,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() => _isObscure = !_isObscure);
                  },
                  icon: Icon(
                    _isObscure
                        ? MaterialCommunityIcons.eye
                        : MaterialCommunityIcons.eye_off,
                    color: widget.isFocused
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                )
              : null,
          labelStyle: TextStyle(
            color: widget.isFocused
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
          ),
        ),
      ),
    );
  }
}

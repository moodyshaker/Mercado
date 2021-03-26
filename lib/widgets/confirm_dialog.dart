import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function onConfirm;
  final Function onCancel;
  final String onConfirmTitle;
  final String onCancelTitle;

  ConfirmDialog({
    @required this.title,
    @required this.content,
    this.onConfirm,
    this.onCancel,
    this.onConfirmTitle,
    this.onCancelTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (cyx, vm, ch) => AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).appBarTheme.textTheme.headline5.copyWith(
                color: vm.isDarkMode ? Colors.white : Colors.black,
              ),
        ),
        content: Text(
          content,
          style: Theme.of(context).appBarTheme.textTheme.headline5.copyWith(
                color: vm.isDarkMode ? Colors.white : Colors.black,
                fontSize: 16.0,
              ),
        ),
        actions: [
          if (onConfirmTitle != null)
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  vm.isDarkMode ? Colors.white : Colors.black,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Text(
                onConfirmTitle,
                style:
                    Theme.of(context).appBarTheme.textTheme.headline5.copyWith(
                          color: vm.isDarkMode ? Colors.black : Colors.white,
                        ),
              ),
              onPressed: onConfirm,
            ),
          if (onCancelTitle != null)
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  vm.isDarkMode ? Colors.white : Colors.black,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Text(
                onCancelTitle,
                style:
                    Theme.of(context).appBarTheme.textTheme.headline5.copyWith(
                          color: vm.isDarkMode ? Colors.black : Colors.white,
                        ),
              ),
              onPressed: onCancel,
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';

class SignInDialog extends StatelessWidget {
  final GeneralProvider vm;
  final String title;
  final String content;
  final String leftAction;
  final String rightAction;
  final Function rightActionOnPress;
  final Function leftActionOnPress;

  SignInDialog({
    @required this.vm,
    @required this.title,
    @required this.content,
    @required this.leftAction,
    @required this.rightAction,
    @required this.rightActionOnPress,
    @required this.leftActionOnPress,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).appBarTheme.textTheme.headline5.copyWith(
              color: Colors.black,
            ),
      ),
      content: Text(
        content,
      ),
      actions: [
        TextButton(
          onPressed: leftActionOnPress,
          child: Text(leftAction),
        ),
        TextButton(
          onPressed: rightActionOnPress,
          child: Text(rightAction),
        )
      ],
      elevation: 20.0,
    );
  }
}

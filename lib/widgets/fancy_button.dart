import 'package:flutter/material.dart';

class FancyButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String title;
  final Function onPress;

  FancyButton({
    @required this.color,
    @required this.textColor,
    @required this.title,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      color: color,
      onPressed: onPress,
    );
  }
}

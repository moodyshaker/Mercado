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
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            color,
          )),
      child: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      onPressed: onPress,
    );
  }
}

import 'package:flutter/material.dart';

class PickerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPickerPress;

  const PickerTile({
    @required this.title,
    @required this.icon,
    @required this.onPickerPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPickerPress,
      leading: Icon(
        icon,
        color: Colors.black,
        size: 30.0,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

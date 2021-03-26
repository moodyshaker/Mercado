import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

class Header5 extends StatelessWidget {
  final String title;
  final double size;
  final Color color;

  const Header5({
    @required this.title,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (ctx, vm, ch) => Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: Theme.of(context).appBarTheme.textTheme.headline5.copyWith(
              color: color ?? (vm.isDarkMode ? Colors.white : Colors.black),
              fontSize: size ?? 20.0,
            ),
      ),
    );
  }
}

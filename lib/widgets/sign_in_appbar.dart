import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

import 'header_text_5.dart';

class SignInAppbar extends StatelessWidget {
  final String imageUrl;
  final List<String> titles;
  final Function onImagePressed;
  final Function onItemPressed;
  final int selectedItem;

  SignInAppbar(
      {@required this.imageUrl,
      @required this.titles,
      @required this.onImagePressed,
      @required this.onItemPressed,
      @required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 30.0,
      ),
      child: Consumer<GeneralProvider>(
        builder: (context, vm, child) => Row(
          children: [
            Expanded(
              child: Row(
                children: titles
                    .map(
                      (title) => GestureDetector(
                        onTap: () => onItemPressed(titles.indexOf(title)),
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: Column(
                            children: [
                              Header5(title: title, size: 18.0),
                              const SizedBox(
                                height: 6.0,
                              ),
                              Container(
                                height: 2.0,
                                width: title.length * 10.0,
                                color: titles.indexOf(title) == selectedItem
                                    ? vm.isDarkMode
                                        ? Colors.white
                                        : Colors.black
                                    : Colors.transparent,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            vm.selectedSignUpIndex == 1
                ? imageUrl == null
                    ? GestureDetector(
                        onTap: onImagePressed,
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 35.0,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: onImagePressed,
                        child: ClipRRect(
                          child: imageUrl.contains('http')
                              ? Image.network(
                                  imageUrl,
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  File(imageUrl),
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.fill,
                                ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      )
                : Container(
                    width: 40.0,
                    height: 40.0,
                  ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mercado/model/checked_model.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

import 'checked_list.dart';
import 'header_text_5.dart';

class ItemOptions extends StatelessWidget {
  final Function onItemClicked;
  final String optionTitle;
  final List<CheckedModel> optionList;
  final int selectedOption;
  final bool isColor;

  ItemOptions({
    @required this.onItemClicked,
    @required this.optionTitle,
    @required this.optionList,
    @required this.selectedOption,
    @required this.isColor,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header5(
            title: optionTitle,
          ),
          SizedBox(height: 8.0),
          CheckedList(
            checkedList: optionList,
            isColors: isColor,
            selectedItem: selectedOption,
            onItemSelcted: onItemClicked,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mercado/model/checked_model.dart';

class CheckedList extends StatelessWidget {
  final List<CheckedModel> checkedList;
  final bool isColors;
  final int selectedItem;
  final Function onItemSelcted;

  CheckedList({
    @required this.checkedList,
    @required this.isColors,
    @required this.selectedItem,
    @required this.onItemSelcted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: checkedList
          .map(
            (item) => isColors
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        onItemSelcted(
                          checkedList.indexOf(item),
                          item,
                        );
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 22.0,
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: item.color,
                            ),
                          ),
                          if (checkedList.indexOf(item) == selectedItem)
                            Positioned(
                              top: 1.0,
                              right: 1.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 9.0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 8.0,
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 14.0,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        onItemSelcted(checkedList.indexOf(item), item);
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor:
                            checkedList.indexOf(item) == selectedItem
                                ? Colors.white
                                : Colors.black,
                        child: CircleAvatar(
                          backgroundColor:
                              checkedList.indexOf(item) == selectedItem
                                  ? Colors.black
                                  : Colors.white,
                          radius: 20.0,
                          child: Text(
                            item.title,
                            style: TextStyle(
                              color: checkedList.indexOf(item) == selectedItem
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          )
          .toList(),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/image_picker_dialog.dart';
import 'package:provider/provider.dart';

class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.purple,
      radius: 50.0,
      child: Consumer<GeneralProvider>(
        builder: (context, vm, child) => Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              child: !vm.isFirstTime
                  ? vm.getImageUrl.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage: vm.getImageUrl.contains('http')
                              ? NetworkImage(vm.getImageUrl)
                              : FileImage(
                                  File(vm.getImageUrl),
                                ),
                          radius: 46.0,
                        )
                      : CircleAvatar(
                          child: Text(
                            '${vm.getName.split(' ')[0][0]}${vm.getName.split(' ')[1][0]}',
                            style: Theme.of(context)
                                .appBarTheme
                                .textTheme
                                .headline6
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                ),
                          ),
                          backgroundColor: Colors.blueAccent,
                          radius: 46,
                        )
                  : Icon(
                      Icons.account_circle,
                      color: Colors.grey,
                      size: 100.0,
                    ),
              backgroundColor: Colors.grey,
              radius: 50.0,
            ),
            GestureDetector(
              onTap: () async {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  builder: (context) => SingleChildScrollView(
                    child: ImagePickerDialog(
                      onImageReceived: (String path) async {
                        vm.setLoading(true);
                        vm.setImageFilePath(path);
                        await vm.updateProfile(photoUrl: vm.imageFilepath);
                        vm.setLoading(false);
                      },
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.black.withOpacity(0.2),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    radius: 20.0,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

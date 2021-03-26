import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mercado/services/auth.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/picker_tile.dart';
import 'package:provider/provider.dart';

class ImagePickerDialog extends StatelessWidget {
  final Function onImageReceived;

  ImagePickerDialog({
    @required this.onImageReceived,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Consumer<GeneralProvider>(
        builder: (context, vm, child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PickerTile(
              onPickerPress: () async {
                String r = await vm.imagePicker(ImageSource.camera);
                if (r == Auth.success) {
                  onImageReceived(vm.imagePath.path);
                  Navigator.pop(context);
                }
              },
              icon: Icons.camera_alt,
              title: 'Camera',
            ),
            PickerTile(
              onPickerPress: () async {
                String r = await vm.imagePicker(ImageSource.gallery);
                if (r == Auth.success) {
                  onImageReceived(vm.imagePath.path);
                  Navigator.pop(context);
                }
              },
              icon: Icons.image,
              title: 'Gallery',
            ),
          ],
        ),
      ),
    );
  }
}

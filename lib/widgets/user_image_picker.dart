import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image;

  void _pickImage() async {
    final ImagePickerPlatform imagePickerImplementation =
        ImagePickerPlatform.instance;
    if (imagePickerImplementation is ImagePickerAndroid) {
      imagePickerImplementation.useAndroidPhotoPicker = true;
    }

    final pickedImage = await ImagePicker().pickImage(
        requestFullMetadata: true,
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _image = File(pickedImage.path);
    });

    widget.onPickImage(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          foregroundImage: _image != null ? FileImage(_image!) : null,
        ),
        const SizedBox(
          height: 10,
        ),
        IconButton(
            onPressed: () {
              _pickImage();
            },
            icon: const Icon(Icons.image_outlined))
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends StatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  String defaultAvatar = "images/morningmenhera.png";

  File? _image;

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  ImageProvider<Object> _buildAvatar() {
    return _image != null
        ? FileImage(_image!)
        : AssetImage(defaultAvatar) as ImageProvider<Object>;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: 140,
      child: Stack(alignment: Alignment.center, children: [
        GestureDetector(
          onTap: _getImage,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: _buildAvatar(),
            foregroundColor: Colors.transparent,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 13,
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              border: Border.fromBorderSide(BorderSide(
                color: Color.fromARGB(255, 68, 68, 68),
                width: 0.3,
              )),
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 10,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.edit,
                size: 18,
              ),
              onPressed: _getImage,
            ),
          ),
        ),
      ]),
    );
  }
}

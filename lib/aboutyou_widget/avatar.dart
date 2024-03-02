// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends StatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  final _profileBox = Hive.box('profileBox');

  String defaultAvatar = "images/morningmenhera.png";
  String tempAvatarPath = ""; // This will be used in the avatar image

  // _profileBox.get('avatarPath') is the default path

  bool _isLoading = false;

  File? _image;

  @override
  void initState() {
    super.initState();
    if (_profileBox.get('avatarPath', defaultValue: '') != '') {
      _image = File(_profileBox.get('avatarPath'));
      tempAvatarPath = _profileBox.get('avatarPath'); // Make it same
    }
    // If there's no image path stored in the box, use the default image
  }

  @override
  Widget build(BuildContext context) {
    // Image is selected from tempAvatarPath which only for the visual
    if (_profileBox.get('tempAvatarPath', defaultValue: '') != '') {
      tempAvatarPath = _profileBox.get('tempAvatarPath');
      _image = File(tempAvatarPath);
    } else {
      tempAvatarPath = defaultAvatar;
      _image = null;
    }

    ImageProvider<Object> _getAvatar() {
      // Just to make safe, ensure that image is not null
      return _image != null
          ? FileImage(_image!)
          : AssetImage(defaultAvatar) as ImageProvider<Object>;
    }

    ImageProvider<Object> _avatarImage = _getAvatar();

    Future<void> _getImage() async {
      // Picking an image, don't run another picker
      setState(() {
        _isLoading = true;
      });

      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _profileBox.put('tempAvatarPath', pickedFile.path);
          _image = File(pickedFile.path);
          _avatarImage = _getAvatar();
        });

        final Directory dir = await getApplicationDocumentsDirectory();

        // Delete the old avatar image if it exists
        final File oldAvatarImage = File('${dir.path}/avatar.jpg');

        if (await oldAvatarImage.exists()) {
          await oldAvatarImage.delete();
        }

        // Save the new avatar image
        final File newAvatarImage =
            await File(pickedFile.path).copy('${dir.path}/avatar.jpg');

        _profileBox.put('avatarPath', newAvatarImage.path);
      }
      
      // Not picking any image anymore, loading complete
      setState(() {
        _isLoading = false;
      });
    }

    return SizedBox(
      height: 110,
      width: 140,
      child: Stack(alignment: Alignment.center, children: [
        GestureDetector(
          onTap: _isLoading ? null : _getImage,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: _avatarImage,
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
              onPressed: _isLoading ? null : _getImage,
            ),
          ),
        ),
      ]),
    );
  }
}

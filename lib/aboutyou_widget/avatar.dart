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

  String defaultAvatar = "images/morningmenhera.png"; // Default avatar image
  String tempAvatarPath = ""; // This will be directly used in the app

  // _profileBox.get('avatarPath') is the default stored path,
  // located from the app's directory

  bool _isLoading = false;

  File? _image;

  @override
  void initState() {
    super.initState();
    if (_profileBox.get('avatarPath', defaultValue: '') != '') {
      _image = File(_profileBox.get('avatarPath'));
      tempAvatarPath = _profileBox.get('avatarPath'); // Make it same for app
    }
    // If there's no image path saved in the storage, use the default image
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

      // Open the image picker from the gallery
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      // If the user picked an image
      if (pickedFile != null) {
        setState(() {
          // Profile pic updated visually
          _profileBox.put('tempAvatarPath', pickedFile.path);
          _image = File(pickedFile.path);
          _avatarImage = _getAvatar();
        });

        // Get the app's local directory
        final Directory dir = await getApplicationDocumentsDirectory();

        // Delete the old avatar image if it exists
        final File oldAvatarImage = File('${dir.path}/avatar.jpg');

        if (await oldAvatarImage.exists()) {
          await oldAvatarImage.delete();
        }

        // Save the new avatar image
        final File newAvatarImage =
            await File(pickedFile.path).copy('${dir.path}/avatar.jpg');

        _profileBox.put('avatarPath', newAvatarImage.path); // Save the path
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

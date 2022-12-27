import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileNotifier extends ChangeNotifier {
  bool isCaregiver = false;
  bool isUser = false;
  bool imageSelected = false;
  XFile? profileEditImage;
  final ImagePicker _picker = ImagePicker();
  bool isLinkAccountOpen = false;
  final TextEditingController profileEditNameController =
      TextEditingController();
  final TextEditingController profileEditSurnameController =
      TextEditingController();
  final TextEditingController profileEditEmailController =
      TextEditingController();
  //profile chooser screen
  bool professionalSelected = false;
  bool userSelected = false;

  void notify() {
    notifyListeners();
  }

  Future<void> pickImage({required bool cameraOrGallery}) async {
    //todo: can be improved for later
    if (cameraOrGallery) {
      profileEditImage = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
    } else {
      profileEditImage = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
    }
    if (profileEditImage != null) {
      imageSelected = true;
      notifyListeners();
    }
  }
}

final profileProvider = ChangeNotifierProvider<ProfileNotifier>((ref) {
  return ProfileNotifier();
});

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ottaa_project_flutter/application/service/profile_services.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/profile_repository.dart';

class ProfileNotifier extends ChangeNotifier {
  final PictogramsRepository _pictogramsService;
  final ProfileRepository _profileService;
  final AuthRepository _auth;

  ProfileNotifier(this._pictogramsService, this._auth, this._profileService);

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

  int day = 0, month = 0, year = 0;

  void notify() {
    notifyListeners();
  }

  int convertDate() {
    final date = DateTime(year, month, day);
    return date.millisecondsSinceEpoch;
  }

  Future<void> updateChanges() async {
    final res = await _auth.getCurrentUser();
    final user = res.right;
    if (imageSelected) {
      /// upload the image and fetch its url
      _profileService.uploadUserImage(
        name: user.name,
        path: profileEditImage!.path,
        userId: user.id,
      );
    }
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
  final pictogramService = GetIt.I<PictogramsRepository>();
  final AuthRepository authService = GetIt.I.get<AuthRepository>();
  final ProfileService profileService = GetIt.I.get<ProfileService>();
  return ProfileNotifier(pictogramService, authService, profileService);
});

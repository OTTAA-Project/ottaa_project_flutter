import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ottaa_project_flutter/core/models/care_giver_user_model.dart';
import 'package:ottaa_project_flutter/core/models/connected_user_data_model.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/profile_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileNotifier extends ChangeNotifier {
  final PictogramsRepository _pictogramsService;
  final ProfileRepository _profileService;
  final AuthRepository _auth;

  ProfileNotifier(this._pictogramsService, this._auth, this._profileService);

  bool isCaregiver = false;
  late UserModel user;
  bool isUser = false;
  bool imageSelected = false;
  XFile? profileEditImage;
  late String imageUrl;
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

  //profile edit screen
  int day = 0, month = 0, year = 0;
  String yearForDropDown = "0";

  //connected users screen
  List<CareGiverUser> connectedUsers = [];
  List<ConnectedUserData> connectedusersData = [];
  bool dataFetched = false;

  void notify() {
    notifyListeners();
  }

  Future<void> setDate() async {
    final res = await _auth.getCurrentUser();
    user = res.right;
    final birthday = user.birthdate!;
    final date = DateTime.fromMillisecondsSinceEpoch(birthday);
    day = date.day;
    month = date.month;
    year = date.year;
    notifyListeners();
  }

  Future<void> openDialer() async {
    Uri callUrl = Uri.parse('tel:=+123456789');
    if (await canLaunchUrl(callUrl)) {
      await launchUrl(callUrl);
    } else {
      throw 'Could not open the dialler.';
    }
  }

  Future<void> openEmail() async {
    final email = Uri(
      scheme: 'mailto',
      path: 'asim@ottaa.com',
      query: 'subject=Hello&body=Test',
    );
    if (await canLaunchUrl(email)) {
      launchUrl(email);
    } else {
      throw 'Could not launch $email';
    }
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
      imageUrl = await _profileService.uploadUserImage(
        name: user.name,
        path: profileEditImage!.path,
        userId: user.id,
      );
    }

    /// create the data for the upload
    final birthdate = convertDate();
    final Map<String, dynamic> data = {
      "name": profileEditNameController.text,
      "birth-date": birthdate,
      "gender-pref": user.gender,
      "last-name": profileEditSurnameController.text,
      "avatar": {
        "name": "local-use",
        "url": imageSelected ? imageUrl : user.photoUrl
      }
    };
    await _profileService.updateUser(data: data, userId: user.id);
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

  Future<void> getConnectedUsers({required String userId}) async {
    connectedUsers = [];
    final res = await _profileService.getConnectedUsers(userId: userId);

    final jso = jsonEncode(res);
    final Map<String, dynamic> json = jsonDecode(jso);
    json.forEach((key, value) {
      connectedUsers.add(CareGiverUser.fromJson(value));
      print(key);
    });
    print('ids are followings');

    /// fetching their names and pics from the database
  }

  Future<void> fetchConnectedUsersData() async {
    connectedusersData = [];
    for (var e in connectedUsers) {
      final res =
          await _profileService.fetchConnectedUserData(userId: e.userId);
      final jso = jsonEncode(res);
      final Map<String, dynamic> json = jsonDecode(jso);
      connectedusersData.add(
        ConnectedUserData(name: json['name'], image: json['avatar']['name']),
      );
      print(json['name']);
    }
    dataFetched = true;
    notifyListeners();
  }

  Future<void> removeCurrentUser(
      {required String userId, required String careGiverId}) async {
    await _profileService.removeCurrentUser(
        userId: userId, careGiverId: careGiverId);

    ///update the whole list again
    dataFetched = false;
    await getConnectedUsers(userId: careGiverId);
    await fetchConnectedUsersData();
    dataFetched = true;
    notifyListeners();
  }
}

final profileProvider = ChangeNotifierProvider<ProfileNotifier>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  final AuthRepository authService = GetIt.I.get<AuthRepository>();
  final ProfileRepository profileService = GetIt.I.get<ProfileRepository>();
  return ProfileNotifier(pictogramService, authService, profileService);
});

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/loading_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_avatar_notifier.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/about_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';

class OnBoardingNotifier extends ChangeNotifier {
  final PageController controller = PageController(initialPage: 0);

  final List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  final AuthRepository _auth;
  final LoadingNotifier _loading;
  final AboutRepository _about;

  final UserAvatarNotifier _userAvatar;
  final LocalDatabaseRepository _localDatabase;

  OnBoardingNotifier(this._auth, this._about, this._localDatabase, this._loading, this._userAvatar);

  void nextPage() {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void previousPage() {
    controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void goToPage(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future<void> signOut() async {
    _loading.showLoading();
    await _auth.logout();
    _loading.hideLoading();
  }

  Future<Either<String, bool>> saveUserInformation() async {
    _loading.showLoading();

    bool isValid = formKeys[0].currentState!.validate();

    if (!isValid) {
      _loading.hideLoading();
      return Left('please_enter_some_text'.trl);
    }

    final result = await _auth.getCurrentUser();

    if (result.isLeft) {
      _loading.hideLoading();
      return Left(result.left);
    }

    final user = result.right;

    List<String> dates = birthDateController.text.split('-');

    DateTime time = DateTime.parse(dates.reversed.join("-"));

    UserModel newUser = user.copyWith(
      name: nameController.text.trim(),
      gender: genderController.text.trim(),
      birthdate: time.millisecondsSinceEpoch,
    );

    _localDatabase.setUser(newUser);

    await _about.uploadUserInformation();

    _loading.hideLoading();
    return const Right(true);
  }

  void changeAvatar(int imageId) {
    _userAvatar.changeAvatar(imageId);
    notifyListeners();
  }

  Future<void> updateUserAvatar() async {
    _loading.showLoading();
    final result = await _auth.getCurrentUser();

    if (result.isLeft) {
      _loading.hideLoading();
      return;
    }

    final user = result.right;
    await _about.uploadProfilePicture(_userAvatar.getAvatar());
    UserModel newUser = user.copyWith(
      avatar: _userAvatar.getAvatar(),
    );

    await _localDatabase.setUser(newUser);

    await _about.uploadUserInformation();
    _loading.hideLoading();
  }
}

final onBoardingProvider = Provider<OnBoardingNotifier>((ref) {
  final auth = GetIt.I<AuthRepository>();
  final about = GetIt.I<AboutRepository>();
  final localDatabase = GetIt.I<LocalDatabaseRepository>();
  final loadingNotifier = ref.watch(loadingProvider.notifier);
  final avatarNotifier = ref.watch(userAvatarNotifier.notifier);
  return OnBoardingNotifier(auth, about, localDatabase, loadingNotifier, avatarNotifier);
});

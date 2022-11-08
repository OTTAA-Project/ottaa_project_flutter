import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/splash_repository.dart';

class SplashServiceImpl extends SplashRepository {
  final databaseRef = FirebaseDatabase.instance.ref();
  final AuthRepository _auth;

  SplashServiceImpl(
    this._auth,
  );

  @override
  Future<void> isCurrentUserAvatarExist({required BuildContext context}) async {
    final result = await _auth.getCurrentUser();
    if (result.isRight) {
      final res = result.right;
      final refNew = databaseRef.child('${res.id}/Usuarios/Avatar/urlFoto/');
      final resNew = await refNew.get();
      if (resNew.exists && resNew.value != null) {
        //todo: add the path to the home Screen
      } else {
        final refOld = databaseRef.child('Avatar/${res.id}/urlFoto/');
        final resOld = await refOld.get();
        print(resOld.value);
        if (resOld.exists && resOld.value != null) {
          //todo: add the path to the home Screen
        }
      }
    } else {
      //todo: add the path to the avatar selection screen
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return _auth.isLoggedIn();
  }
}

import 'package:ottaa_project_flutter/core/models/care_giver_user_model.dart';

abstract class ProfileRepository {
  Future<String> uploadUserImage(
      {required String path, required String name, required String userId});

  Future<void> updateUser(
      {required Map<String, dynamic> data, required String userId});

  Future<dynamic> getConnectedUsers({required String userId});

  Future<dynamic> fetchConnectedUserData({required String userId});

  Future<void> removeCurrentUser({required String userId,required String careGiverId});
}

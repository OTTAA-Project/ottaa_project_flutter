import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/repositories/profile_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

class ProfileService implements ProfileRepository {
  final ServerRepository _serverRepository;

  ProfileService(this._serverRepository);

  @override
  Future<void> updateUserSettings({required Map<String, dynamic> data, required String userId}) async {
    return await _serverRepository.updateUserSettings(data: data, userId: userId);
  }

  @override
  Future<String> uploadUserImage({required String path, required String name, required String userId}) async {
    return await _serverRepository.uploadUserImage(path: path, name: name, userId: userId);
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getConnectedUsers({required String userId}) async {
    return await _serverRepository.getConnectedUsers(userId: userId);
  }

  @override
  Future<Either<String, Map<String, dynamic>>> fetchConnectedUserData({required String userId}) async {
    return await _serverRepository.fetchConnectedUserData(userId: userId);
  }

  @override
  Future<void> removeCurrentUser({required String userId, required String careGiverId}) async {
    return await _serverRepository.removeCurrentUser(userId: userId, careGiverId: careGiverId);
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getProfileById({required String id}) {
    return _serverRepository.getProfileById(id: id);
  }

  @override
  Future<void> updateUser({required Map<String, dynamic> data, required String userId}) async{
    await _serverRepository.uploadUserInformation(userId, data);
  }
}

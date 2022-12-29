import 'package:ottaa_project_flutter/core/repositories/profile_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

class ProfileService implements ProfileRepository {
  final ServerRepository _serverRepository;

  ProfileService(this._serverRepository);

  @override
  Future<void> updateUserData(
          {required Map<String, dynamic> data, required String userId}) async =>
      await _serverRepository.updateUserData(data: data, userId: userId);

  @override
  Future<String> uploadUserImage(
          {required String path,
          required String name,
          required String userId}) async =>
      await _serverRepository.uploadUserImage(
          path: path, name: name, userId: userId);
}

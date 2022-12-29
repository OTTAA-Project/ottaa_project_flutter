abstract class ProfileRepository {
  Future<String> uploadUserImage(
      {required String path, required String name, required String userId});
  Future<void> updateUser(
      {required Map<String, dynamic> data, required String userId});
}

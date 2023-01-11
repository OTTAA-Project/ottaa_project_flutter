import 'package:either_dart/either.dart';

abstract class ProfileRepository {
  Future<String> uploadUserImage({required String path, required String name, required String userId});

  Future<void> updateUser({required Map<String, dynamic> data, required String userId});

  Future<Either<String, Map<String, dynamic>>> getConnectedUsers({required String userId});

  Future<Either<String, Map<String, dynamic>>> fetchConnectedUserData({required String userId});

  Future<void> removeCurrentUser({required String userId, required String careGiverId});
}

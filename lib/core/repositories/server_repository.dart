import 'package:ottaa_project_flutter/core/enums/user_types.dart';

abstract class ServerRepository {
  Future<void> init();
  Future<void> close();

  Future<String> getAvailableAppVersion();

  Future<UserType> getUserType(String userId);

  Future<String?> getUserProfilePicture(String userId);

  Future<void> uploadUserPicture(String userId, String picture, String photoUrl);

  Future<Map<String, dynamic>?> getUserInformation(String id);

  Future<void> uploadUserInformation(String userId, Map<String, dynamic> data);

  Future<List<Map<String, dynamic>>> getUserSentences(String userId, {required String language, required String type, bool isFavorite = false});

  Future<void> uploadUserSentences(String userId, String language, String type, List<Map<String, dynamic>> data);

  Future<List<Map<String, dynamic>>?> getAllPictograms(String userId, String languageCode);

  Future<void> uploadPictograms(String userId, String language, {required List<Map<String, dynamic>> data});

  Future<void> updatePictogram(String userId, String language, int index, {required Map<String, dynamic> data});

  Future<List<Map<String, dynamic>>?> getAllGroups(String userId, String languageCode);

  Future<void> uploadGroups(String userId, String language, {required List<Map<String, dynamic>> data});

  Future<void> updateGroup(String userId, String language, int index, {required Map<String, dynamic> data});

  Future<Map<String, dynamic>?> getPictogramsStatistics(String userId, String languageCode);

  Future<Map<String, dynamic>?> getMostUsedSentences(String userId, String languageCode);
}

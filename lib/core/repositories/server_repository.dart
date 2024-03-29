import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/sentence_model.dart';

typedef EitherVoid = Either<String, void>;
typedef EitherString = Either<String, String>;
typedef EitherListMap = Either<String, List<Map<String, dynamic>>>;
typedef EitherMap = Either<String, Map<String, dynamic>>;

abstract class ServerRepository {
  Future<void> init();
  Future<void> close();

  Future<EitherString> getAvailableAppVersion(String platform);

  Future<UserType> getUserType(String userId);

  Future<EitherString> getUserProfilePicture(String userId);

  Future<EitherVoid> uploadUserPicture(String userId, String picture, String photoUrl);

  Future<EitherMap> getUserInformation(String id);

  Future<EitherVoid> uploadUserInformation(String userId, Map<String, dynamic> data);

  Future<List<SentenceModel>> getUserSentences(String userId, {required String language, required String type, bool isFavorite = false});

  Future<EitherVoid> uploadUserSentences(String userId, String language, String type, List<Map<String, dynamic>> data);

  Future<EitherListMap> getAllPictograms(String userId, String languageCode);

  Future<EitherVoid> uploadPictograms(String userId, String language, {required List<Map<String, dynamic>> data});

  Future<EitherVoid> updatePictogram(String userId, String language, int index, {required Map<String, dynamic> data});

  Future<EitherListMap> getAllGroups(String userId, String languageCode);

  Future<EitherVoid> uploadGroups(String userId, String language, {required List<Map<String, dynamic>> data});

  Future<EitherVoid> updateGroup(String userId, String language, int index, {required Map<String, dynamic> data});

  Future<EitherMap> getPictogramsStatistics(String userId, String languageCode);

  Future<EitherMap> getMostUsedSentences(String userId, String languageCode);
}

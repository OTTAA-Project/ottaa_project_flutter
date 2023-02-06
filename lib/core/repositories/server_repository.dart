import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/enums/board_data_type.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';

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

  Future<EitherVoid> uploadUserPicture(String userId, AssetsImage image);

  Future<EitherMap> getUserInformation(String id);

  Future<EitherVoid> uploadUserInformation(String userId, Map<String, dynamic> data);

  Future<List<Phrase>> getUserSentences(String userId, {required String language, required String type, bool isFavorite = false});

  Future<EitherVoid> uploadUserSentences(String userId, String language, String type, List<Map<String, dynamic>> data);

  Future<EitherListMap> getAllPictograms(String userId, String languageCode);

  Future<EitherVoid> uploadPictograms(String userId, String language, {required List<Map<String, dynamic>> data});

  Future<EitherVoid> updatePictogram(String userId, String language, int index, {required Map<String, dynamic> data});

  Future<EitherListMap> getAllGroups(String userId, String languageCode);

  Future<EitherVoid> uploadGroups(String userId, String language, {required List<Map<String, dynamic>> data});

  Future<EitherVoid> updateGroup(String userId, String language, int index, {required Map<String, dynamic> data});

  Future<EitherMap> getPictogramsStatistics(String userId, String languageCode);

  Future<EitherMap> getMostUsedSentences(String userId, String languageCode);

  Future<String> uploadUserImage({required String path, required String name, required String userId});

  Future<void> updateUserSettings({required Map<String, dynamic> data, required String userId});

  Future<EitherMap> getConnectedUsers({required String userId});

  Future<EitherMap> fetchConnectedUserData({required String userId});

  Future<void> removeCurrentUser({required String userId, required String careGiverId});

  Future<EitherVoid> setShortcutsForUser({required Shortcuts shortcuts, required String userId});

  Future<void> updateUserData({required Map<String, dynamic> data, required String userId});

  Future<EitherMap> getEmailToken(String ownEmail, String email);

  Future<EitherMap> verifyEmailToken(String ownEmail, String email, String token);

  Future<EitherMap> getProfileById({required String id});

  Future<dynamic> getDefaultGroups(String languageCode);

  Future<dynamic> getDefaultPictos(String languageCode);

  Future<void> updateUserType({required String id, required UserType userType});

  Future<Map<String, dynamic>?> createPictoGroupData({
    required String userId,
    required String language,
    required BoardDataType type,
    required Map<String, dynamic> data,
  });

  Future<EitherMap> learnPictograms({
    required String uid,
    required String language,
    required String model,
    required List<Map<String, dynamic>> tokens,
  });

  Future<EitherMap> predictPictogram({
    required String sentence,
    required String uid,
    required String language,
    required String model,
    required List<String> groups,
    required Map<String, List<String>> tags,
    bool reduced = false,
  });

  Future<EitherVoid> updateUserLastConnectionTime({required String userId, required int time});
}

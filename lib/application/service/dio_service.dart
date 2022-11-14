import 'package:dio/dio.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

class DIOServerRepository implements ServerRepository {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://your-endpoint-url.com"),
  );

  String? _token;

  @override
  Future<void> init() async {
    await genCSRF();
  }

  Future<void> genCSRF() async {
    final Response response = await _dio.get("/csrf-cookie");
    _token = response.headers.value("set-cookie")?.split(";")[0].split("=")[1];
  }

  @override
  Future<void> close() async {
    return _dio.close();
  }

  @override
  Future<List<Map<String, dynamic>>?> getAllGroups(String userId, String languageCode) async {
    final Response response = await _dio.get("/groups",
        queryParameters: {
          "user_id": userId,
          "language_code": languageCode,
        },
        options: Options(headers: {
          "cookie": "XSRF-TOKEN=$_token",
        }));

    if (response.statusCode == 200) {
      return response.data;
    }

    return null;
  }

  @override
  Future<List<Map<String, dynamic>>?> getAllPictograms(String userId, String languageCode) async {
    final Response response = await _dio.get("/pictograms",
        queryParameters: {
          "user_id": userId,
          "language_code": languageCode,
        },
        options: Options(headers: {
          "cookie": "XSRF-TOKEN=$_token",
        }));

    if (response.statusCode == 200) {
      return response.data;
    }

    return null;
  }

  @override
  Future<String> getAvailableAppVersion() async {
    final Response response = await _dio.get("/app_version",
        queryParameters: {
          "platform": "android",
        },
        options: Options(headers: {
          "cookie": "XSRF-TOKEN=$_token",
        }));

    if (response.statusCode == 200) {
      return response.data["version"];
    }

    return "";
  }

  @override
  Future<Map<String, dynamic>?> getUserInformation(String id) async {
    final Response response = await _dio.get("/users",
        queryParameters: {
          "id": id,
        },
        options: Options(headers: {
          "cookie": "XSRF-TOKEN=$_token",
        }));

    if (response.statusCode == 200) {
      return response.data;
    }

    return null;
  }

  @override
  Future<String?> getUserProfilePicture(String userId) async {
    final Response response = await _dio.get("/users",
        queryParameters: {
          "id": userId,
        },
        options: Options(headers: {
          "cookie": "XSRF-TOKEN=$_token",
        }));

    if (response.statusCode == 200) {
      return response.data["profile_picture"];
    }

    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> getUserSentences(String userId, {required String language, required String type, bool isFavorite = false}) async {
    final Response response = await _dio.get("/sentences",
        queryParameters: {
          "user_id": userId,
          "language_code": language,
          "type": type,
          "is_favorite": isFavorite,
        },
        options: Options(headers: {
          "cookie": "XSRF-TOKEN=$_token",
        }));

    if (response.statusCode == 200) {
      return response.data;
    }

    return [];
  }

  @override
  Future<UserType> getUserType(String userId) async {
    final Response response = await _dio.get(
      "/payments",
      queryParameters: {
        "id": userId,
      },
      options: Options(headers: {
        "cookie": "XSRF-TOKEN=$_token",
      }),
    );

    if (response.statusCode == 200) {
      return UserType.premium;
    }

    return UserType.free;
  }

  @override
  Future<void> updateGroup(String userId, String language, int index, {required Map<String, dynamic> data}) async {
    final Response response = await _dio.put("/groups",
        queryParameters: {
          "user_id": userId,
          "language_code": language,
          "index": index,
        },
        data: data,
        options: Options(headers: {
          "cookie": "XSRF-TOKEN=$_token",
        }));

    if (response.statusCode == 200) {
      return;
    }

    throw Exception("Error updating group");
  }

  @override
  Future<void> updatePictogram(String userId, String language, int index, {required Map<String, dynamic> data}) async {
    final Response response = await _dio.put("/pictograms",
        queryParameters: {
          "user_id": userId,
          "language_code": language,
          "index": index,
        },
        data: data,
        options: Options(headers: {
          "cookie": "XSRF-TOKEN=$_token",
        }));

    if (response.statusCode == 200) {
      return;
    }

    throw Exception("Error updating pictogram");
  }

  @override
  Future<void> uploadGroups(String userId, String language, {required List<Map<String, dynamic>> data}) async {
    final Response response = await _dio.post("/groups",
        queryParameters: {
          "user_id": userId,
          "language_code": language,
        },
        data: data,
        options: Options(headers: {
          "cookie": "XSRF-TOKEN=$_token",
        }));

    if (response.statusCode == 200) {
      return;
    }

    throw Exception("Error uploading groups");
  }

  @override
  Future<void> uploadPictograms(String userId, String language, {required List<Map<String, dynamic>> data}) async {
    final Response response = await _dio.post("/pictograms",
        queryParameters: {
          "user_id": userId,
          "language_code": language,
        },
        data: data,
        options: Options(headers: {
          "cookie": "XSRF-TOKEN=$_token",
        }));

    if (response.statusCode == 200) {
      return;
    }

    throw Exception("Error uploading pictograms");
  }

  @override
  Future<void> uploadUserInformation(String userId, Map<String, dynamic> data) async {
    final Response response = await _dio.put(
      "/users",
      queryParameters: {
        "id": userId,
      },
      data: data,
      options: Options(headers: {
        "cookie": "XSRF-TOKEN=$_token",
      }),
    );

    if (response.statusCode == 200) {
      return;
    }

    throw Exception("Error uploading user information");
  }

  @override
  Future<void> uploadUserPicture(String userId, String picture, String photoUrl) async {
    final Response response = await _dio.put(
      "/users/picture",
      queryParameters: {
        "id": userId,
      },
      data: {
        "profile_picture": picture,
        "photo_url": photoUrl,
      },
      options: Options(headers: {
        "cookie": "XSRF-TOKEN=$_token",
      }),
    );

    if (response.statusCode == 200) {
      return;
    }

    throw Exception("Error uploading user picture");
  }

  @override
  Future<void> uploadUserSentences(String userId, String language, String type, List<Map<String, dynamic>> data) async {
    final Response response = await _dio.post("/sentences",
        queryParameters: {
          "user_id": userId,
          "language_code": language,
          "type": type,
        },
        data: data,
        options: Options(headers: {
          "cookie": "XSRF-TOKEN=$_token",
        }));

    if (response.statusCode == 200) {
      return;
    }

    throw Exception("Error uploading user sentences");
  }
}

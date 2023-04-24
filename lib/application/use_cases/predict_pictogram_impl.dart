import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/models/picto_predicted.dart';
import 'package:ottaa_project_flutter/core/models/picto_predicted_reduced.dart';
import 'package:ottaa_project_flutter/core/use_cases/predict_pictogram.dart';

@Singleton(as: PredictPictogram)
class PredictPictogramImpl extends PredictPictogram {
  PredictPictogramImpl({required super.serverRepository});

  @override
  Future<Either<String, List<PictoPredictedReduced>>> call({
    required String sentence,
    required String uid,
    required String language,
    required String model,
    List<String> groups = const [],
    Map<String, List<String>> tags = const {},
    bool reduced = true,
    int limit = 10,
    int chunk = 4,
    CancelToken? cancelToken,
  }) async {
    final response = await serverRepository.predictPictogram(
        sentence: sentence,
        uid: uid,
        language: language,
        model: model,
        groups: groups,
        tags: tags,
        cancelToken: cancelToken);

    if (response.isLeft) {
      return Left(response.left);
    }

    final map = response.right["data"];

    if (reduced) {
      return Right(map
          .map<PictoPredictedReduced>((e) => PictoPredictedReduced.fromMap(e))
          .toList());
    }

    return Right(
        map.map<PictoPredicted>((e) => PictoPredicted.fromMap(e)).toList());
  }
}

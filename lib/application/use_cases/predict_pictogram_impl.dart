import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/models/picto_predicted.dart';
import 'package:ottaa_project_flutter/core/models/picto_predicted_reduced.dart';
import 'package:ottaa_project_flutter/core/use_cases/predict_pictogram.dart';

class PredictPictogramImpl extends PredictPictogram {
  PredictPictogramImpl({required super.serverRepository});

  @override
  Future<Either<String, PictoPredictedReduced>> call({
    required String sentence,
    required String uid,
    required String language,
    required String model,
    List<String> groups = const [],
    Map<String, List<String>> tags = const {},
    bool reduced = true,
  }) async {
    final response = await serverRepository.predictPictogram(
      sentence: sentence,
      uid: uid,
      language: language,
      model: model,
      groups: groups,
      tags: tags,
    );

    if (response.isLeft) {
      return Left(response.left);
    }

    final map = response.right;

    if (reduced) {
      return Right(PictoPredictedReduced.fromMap(map));
    }

    return Right(PictoPredicted.fromMap(map));
  }
}

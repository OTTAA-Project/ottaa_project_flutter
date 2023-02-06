import 'package:ottaa_project_flutter/core/use_cases/predict_pictogram.dart';

class PredictPictogramImpl extends PredictPictogram {
  PredictPictogramImpl({required super.serverRepository});

  @override
  Future<dynamic> call({
    required String sentence,
    required String uid,
    required String language,
    required String model,
    List<String> groups = const [],
    Map<String, List<String>> tags = const {},
  }) async {
    final response = serverRepository.predictPictogram(
      sentence: sentence,
      uid: uid,
      language: language,
      model: model,
      groups: groups,
      tags: tags,
    );
  }
}

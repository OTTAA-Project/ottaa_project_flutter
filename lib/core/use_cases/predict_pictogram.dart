import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

abstract class PredictPictogram {
  ServerRepository serverRepository;

  PredictPictogram({
    required this.serverRepository,
  });


  /// Call for predict pictograms, [sentence] is the sentence to predict,
  /// [uid] is the user id, [language] is the language of the sentence,
  /// [model] is the model to use, [groups] is the list of groups to predict and it is used to filter the pictograms,
  /// [tags] is the map of tags to predict and it is used to filter the pictograms
  Future<dynamic> call({
    required String sentence,
    required String uid,
    required String language,
    required String model,
    required List<String> groups,
    required Map<String, List<String>> tags,
  });
}

import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

abstract class PredictPictogram {
  ServerRepository serverRepository;

  PredictPictogram({
    required this.serverRepository,
  });

  Future<dynamic> call({
    String sentence,
    String uid,
    String language,
    String model,
    List<String> groups,
    Map<String, dynamic> tags,
  });
}

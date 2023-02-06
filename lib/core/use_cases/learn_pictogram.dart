import 'package:ottaa_project_flutter/core/models/learn_token.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

abstract class LearnPictogram {
  ServerRepository serverRepository;

  LearnPictogram({
    required this.serverRepository,
  });

  Future<void> call({
    String sentence,
    String uid,
    String language,
    String model,
    List<LearnToken> tokens,
  });


}

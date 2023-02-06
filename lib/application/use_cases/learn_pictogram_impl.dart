import 'package:ottaa_project_flutter/core/models/learn_token.dart';
import 'package:ottaa_project_flutter/core/use_cases/learn_pictogram.dart';

class LearnPictogramImpl extends LearnPictogram {
  LearnPictogramImpl({required super.serverRepository});

  @override
  Future<void> call({
    @Deprecated("You should use tokens instead of this") String sentence = "",
    required String uid,
    required String language,
    required String model,
    required List<LearnToken> tokens,
  }) async {
    // TODO: implement call
    throw UnimplementedError();
  }
}

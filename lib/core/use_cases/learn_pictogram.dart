import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/models/learn_token.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

abstract class LearnPictogram {
  ServerRepository serverRepository;

  LearnPictogram({
    required this.serverRepository,
  });

  /// Call for learn pictograms, [sentence] is deprecated, use [tokens] instead
  /// [sentence] or [tokens] is the sentence to learn, [uid] is the user id,
  /// [language] is the language of the sentence, [model] is the model to use
  ///
  /// Return a [Either] with the [Left] containing the error message or the [Right]
  /// containing the sentence learned
  Future<Either<String, String>> call({
    @Deprecated("You should use tokens instead of this") String? sentence,
    required String uid,
    required String language,
    required String model,
    required List<LearnToken> tokens,
  });
}

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/models/learn_token.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';
import 'package:ottaa_project_flutter/core/use_cases/learn_pictogram.dart';

@Singleton(as: LearnPictogram)
class LearnPictogramImpl extends LearnPictogram {
  LearnPictogramImpl({required super.serverRepository});

  @override
  Future<EitherString> call({
    @Deprecated("You should use tokens instead of this") String? sentence = "",
    required String uid,
    required String language,
    required String model,
    required List<LearnToken> tokens,
  }) async {
    final response = await serverRepository.learnPictograms(
      uid: uid,
      language: language,
      model: model,
      tokens: tokens.map((e) => e.toMap()).toList(),
    );

    if (response.isLeft) return Left(response.left);

    final data = response.right;

    return Right(data["success"]);
  }
}

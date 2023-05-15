import 'package:either_dart/either.dart';

abstract class ChatGPTRepository {
  const ChatGPTRepository();

  Future<Either<String, String>> getCompletion({
    required int age,
    required String gender,
    required String pictograms,
    required String language,
    int maxTokens = 500,
  });

  Future<Either<String, String>> getGPTStory({
    required String prompt,
    int maxTokens = 1000,
  });
}

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/core/repositories/chatgpt_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

@Singleton(as: ChatGPTRepository)
class ChatGPTService extends ChatGPTRepository {
  final ServerRepository serverService;

  const ChatGPTService(this.serverService);

  @override
  Future<Either<String, String>> getCompletion({required String age, required String gender, required String pictograms}) async {
    final prompt = "chatgpt.prompt".trlf({"age": age, "gender": gender, "pictograms": pictograms});

    final response = await serverService.generatePhraseGPT(prompt: prompt);

    return response.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}

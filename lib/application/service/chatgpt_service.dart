import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/core/repositories/chatgpt_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_config_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

@Singleton(as: ChatGPTRepository)
class ChatGPTService extends ChatGPTRepository {
  final ServerRepository serverService;

  final RemoteConfigRepository remoteConfigService;

  const ChatGPTService(this.serverService, this.remoteConfigService);

  @override
  Future<Either<String, String>> getCompletion({
    required int age,
    required String gender,
    required String pictograms,
    required String language,
    int maxTokens = 500,
  }) async {
    String? remotePrompt = await remoteConfigService.getString("ChatGPTPromt");
    String type;

    if (age <= 13) {
      type = "niño";
    } else if (age > 13 && age < 18) {
      type = "adolescente";
    } else {
      type = "adulto";
    }

    if (remotePrompt != null) {
      remotePrompt = remotePrompt.replaceAll("{AGE}", type).replaceAll("{SEX}", gender).replaceAll("{PHRASE}", pictograms).replaceAll("{LANG}", language);
    }

    final prompt = remotePrompt ?? "chatgpt.prompt".trlf({"age": type, "gender": gender, "pictograms": pictograms, "language": language});

    final response = await serverService.generatePhraseGPT(
      prompt: prompt,
      maxTokens: maxTokens,
    );

    return response.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<String, String>> getStory({
    required String prompt,
    int maxTokens = 1000,
  }) async {
    String? remotePrompt = await remoteConfigService.getString("ChatGPTPromt");

    final response = await serverService.generatePhraseGPT(prompt: prompt, maxTokens: maxTokens, temperature: 0.7);
    return response.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}

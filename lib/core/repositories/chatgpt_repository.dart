import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

abstract class ChatGPTRepository {
  final ServerRepository serverService;

  const ChatGPTRepository(this.serverService);

  Future<Either<String, String>> getCompletion({required String age, required String gender, required String pictograms});
}

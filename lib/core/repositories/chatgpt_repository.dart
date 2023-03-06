import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

abstract class ChatGPTRepository {

  const ChatGPTRepository();

  Future<Either<String, String>> getCompletion({required String age, required String gender, required String pictograms});
}

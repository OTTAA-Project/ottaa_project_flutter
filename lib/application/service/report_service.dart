import 'package:ottaa_project_flutter/core/models/phrases_statistics_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_statistics_model.dart';
import 'package:ottaa_project_flutter/core/repositories/report_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

class ReportService implements ReportRepository {
  final ServerRepository _serverRepository;

  ReportService(this._serverRepository);

  @override
  Future<PhraseStatisticModel?> getMostUsedSentences(String userId, String languageCode) async {
    final response = await _serverRepository.getMostUsedSentences(userId, languageCode);

    if (response.isRight) {
      return PhraseStatisticModel.fromJson(response.right);
    }

    return null;
  }

  @override
  Future<PictoStatisticsModel?> getPictogramsStatistics(String userId, String languageCode) async {
    final response = await _serverRepository.getPictogramsStatistics(userId, languageCode);

    if (response.isRight) {
      return PictoStatisticsModel.fromJson(response.right);
    }

    return null;
  }
}

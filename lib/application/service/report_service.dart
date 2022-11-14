import 'package:ottaa_project_flutter/core/models/sentence_statistics_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_statistics_model.dart';
import 'package:ottaa_project_flutter/core/repositories/report_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

class ReportService implements ReportRepository {
  final ServerRepository _serverRepository;

  ReportService(this._serverRepository);

  @override
  Future<FrasesStatisticsModel?> getMostUsedSentences(String userId, String languageCode) async {
    final response = await _serverRepository.getMostUsedSentences(userId, languageCode);

    if (response != null) {
      return FrasesStatisticsModel.fromJson(response);
    }

    return null;
  }

  @override
  Future<PictoStatisticsModel?> getPictogramsStatistics(String userId, String languageCode) async {
    final response = await _serverRepository.getPictogramsStatistics(userId, languageCode);

    if (response != null) {
      return PictoStatisticsModel.fromJson(response);
    }

    return null;
  }
}

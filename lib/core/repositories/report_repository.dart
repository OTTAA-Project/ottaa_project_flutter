import 'package:ottaa_project_flutter/core/models/picto_statistics_model.dart';
import 'package:ottaa_project_flutter/core/models/sentence_statistics_model.dart';

abstract class ReportRepository {
  Future<PictoStatisticsModel?> getPictogramsStatistics(String userId, String languageCode);

  Future<FrasesStatisticsModel?> getMostUsedSentences(String userId, String languageCode);
}

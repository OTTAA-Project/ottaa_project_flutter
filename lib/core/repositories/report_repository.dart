import 'package:ottaa_project_flutter/core/models/phrases_statistics_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_statistics_model.dart';

abstract class ReportRepository {
  Future<PictoStatisticsModel?> getPictogramsStatistics(
      String userId, String languageCode);

  Future<PhraseStatisticModel?> getMostUsedSentences(
      String userId, String languageCode);
}

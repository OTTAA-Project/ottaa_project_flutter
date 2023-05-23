import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/report_service.dart';
import 'package:ottaa_project_flutter/core/models/phrases_statistics_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

import 'report_service_test.mocks.dart';

@GenerateMocks([
  ServerRepository,
])
Future<void> main() async {
  late MockServerRepository mockServerRepository;
  PhraseStatisticModel phraseStatisticModel = PhraseStatisticModel(
    totalFrases: 0,
    frases7Days: 00,
    averagePictoFrase: 00,
    frecLast7Days: {
      '0': 00,
      '1': 00,
      '2': 00,
      '3': 00,
      '4': 0012,
    },
  );
  // PictoStatisticsModel pictoStatisticsModel = PictoStatisticsModel(mostUsedSentences: [
  //   MostUsedSentence(
  //     frec: 00,
  //     pictoComponentes: [
  //       PictoComponente(id: '00', esSugerencia: false, hora: ['test'], sexo: ['test'], edad: ['test']),
  //     ],
  //   ),
  //   MostUsedSentence(
  //     frec: 11,
  //     pictoComponentes: [
  //       PictoComponente(id: '11', esSugerencia: false, hora: ['test'], sexo: ['test'], edad: ['test']),
  //     ],
  //   ),
  // ], pictoUsagePerGroup: [
  //   PictoUsagePerGroup(
  //     groupId: 00,
  //     percentage: 00,
  //     name: Name(en: '', es: '', fr: '', pt: ''),
  //   )
  // ]);

  late ReportRepository reportRepository;
  setUp(() {
    mockServerRepository = MockServerRepository();
    reportRepository = ReportService(mockServerRepository);
  });

  test('should return most used sentences from the user ', () async {
    when(mockServerRepository.getMostUsedSentences(any, any)).thenAnswer((_) async {
      return Right(phraseStatisticModel.toJson());
    });

    final response = await reportRepository.getMostUsedSentences('testId', 'es_AR');

    expect(response, isA<PhraseStatisticModel>());
  });

  test('should return null if most used sentences are not found from the user ', () async {
    when(mockServerRepository.getMostUsedSentences(any, any)).thenAnswer((_) async {
      return const Left('null');
    });

    final response = await reportRepository.getMostUsedSentences('testId', 'es_AR');

    expect(response, null);
  });

  //todo: model is not working
  /*test('should return pictogram statics from the user ', () async {
    when(mockServerRepository.getPictogramsStatistics(any, any)).thenAnswer((_) async {
      return Right(pictoStatisticsModel.toJson());
    });

    final response = await reportRepository.getPictogramsStatistics('testId', 'es_AR');

    expect(response, isA<PictoStatisticsModel>());
  });*/

  test('should return null if pictogram statics are not found from the user ', () async {
    when(mockServerRepository.getPictogramsStatistics(any, any)).thenAnswer((_) async {
      return const Left('null');
    });

    final response = await reportRepository.getPictogramsStatistics('testId', 'es_AR');

    expect(response, null);
  });
}

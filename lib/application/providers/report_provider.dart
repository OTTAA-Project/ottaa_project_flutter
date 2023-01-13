import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/service/report_service.dart';
import 'package:ottaa_project_flutter/core/models/chart_model.dart';
import 'package:ottaa_project_flutter/core/models/phrases_statistics_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_statistics_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/report_repository.dart';

class ReportProvider extends ChangeNotifier {
  final PictogramsRepository _pictogramsService;
  final ReportRepository _reportService;
  final AuthRepository _auth;

  ReportProvider(this._pictogramsService, this._reportService, this._auth);

  final PageController pageController = PageController();

  late Timer _timer;
  late String uid;
  int currentPage = 0;
  String photoUrl = '';
  bool chartShow = false;
  double scorePercentageScore = 0.00;
  double firstValueProgress = 0.00;
  double secondValueProgress = 0.00;
  double thirdValueProgress = 0.00;
  double fourthValueProgress = 0.00;
  String firstValueText = 'first';
  String secondValueText = 'second';
  String thirdValueText = 'third';
  String fourthValueText = 'fourth';
  List<List<String>> mostUsedSentences = [];
  late PictoStatisticsModel pictoStatisticsModel;
  late PhraseStatisticModel frasesStatisticsModel;
  late List<String> randomPictos;
  late List<Picto> _pictos;
  double averagePictoFrase = 0.00;
  bool loadingMostUsedSentences = false;
  int frases7Days = 0;
  List<ChartModel> chartModel = [];
  late double scoreForProfile;
  double scoreProfile = 0.00;

  Future<void> init() async {
    //todo: fetching the required things
    _pictos = await _pictogramsService.getAllPictograms();
    final user = await _auth.getCurrentUser();
    uid = user.right.id;
    photoUrl = user.right.settings.data.avatar.network!;
    await fetchPictoStatisticsData();
    await fetchMostUsedSentences();
    calculateScoreForProfile();
  }

  void onClose() {
    //todo: close the timer for the bottom widget carousel
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  Future<void> fetchPictoStatisticsData() async {
    final pictosResponse = await _reportService.getPictogramsStatistics(uid, "es_AR"); //TODO: Connect to service

    if (pictosResponse == null) return;

    pictoStatisticsModel = pictosResponse;
    notifyListeners();
    await makeMostUsedSentencesList();
  }

  Future<void> fetchMostUsedSentences() async {
    // print(res.body);
    final sentencesResponse = await _reportService.getMostUsedSentences(uid, "es_AR"); //TODO: Connect to service

    if (sentencesResponse == null) return;

    frasesStatisticsModel = sentencesResponse;
    frases7Days = frasesStatisticsModel.frases7Days;
    averagePictoFrase = frasesStatisticsModel.averagePictoFrase;
    notifyListeners();
  }

  Future<void> makeMostUsedSentencesList() async {
    /// creating a list to add all of the ids
    List<List<int>> pictosIds = [];
    for (var element in pictoStatisticsModel.mostUsedSentences) {
      List<int> res = [];
      for (var element in element.pictoComponentes) {
        res.add(element.id);
        // print(element.id);
      }
      pictosIds.add(res);
    }

    /// getting the strings for the selected ids from the data
    List<List<String>> selectedPictosUrl = [];
    for (var element in pictosIds) {
      List<String> res = [];
      for (var id in element) {
        for (var element in _pictos) {
          if (element.id == id) {
            final val = element.resource.network!;
            res.add(val);
          }
        }
      }
      selectedPictosUrl.add(res);
    }
    mostUsedSentences = selectedPictosUrl;
    loadingMostUsedSentences = true;
    notifyListeners();
    initializePageViewer();
  }

  void initializePageViewer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
      notifyListeners();
    });
  }

  void calculateScoreForProfile() {
    ///last7DaysUsage = number of days the user used the app in the last 7 days.
    /// sentences7days = sentences created in the last 7 days.
    /// averagePictoFrase = average pictograms per sentence.
    /// usedGroups = number of different used groups.
    int usedGrupos = 0;
    frasesStatisticsModel.frecLast7Days.forEach((key, value) {
      // print('here is the values from the map');
      // final date = DateTime.fromMillisecondsSinceEpoch(
      //   int.parse(key),
      // );
      // final month = DateFormat.MMMM().format(date);
      // print('${date.day} $month ${date.year}');
      chartModel.add(
        ChartModel(year: int.parse(key), count: value),
      );
      // print('$key : $value');
    });
    // print(chartModel.length);
    // print(chartModel.last.year);
    for (var element in pictoStatisticsModel.pictoUsagePerGroup) {
      if (element.percentage > 0.0) {
        usedGrupos++;
      }
    }
    int a = 500, b = 3, c = 500, d = 44, last7DaysUsage = 0;
    frasesStatisticsModel.frecLast7Days.forEach((key, value) {
      last7DaysUsage = last7DaysUsage + value;
    });
    double score = 0;
    score = (last7DaysUsage * a) + (frasesStatisticsModel.frases7Days * b) + (averagePictoFrase * c) + (usedGrupos * d);
    scoreProfile = score;
    String val = score.toString();
    val = val.substring(1);
    scorePercentageScore = double.parse(val) / 10;
    // print(score);
    // return (int)(score / 1000);
    chartShow = true;
    //todo: update charts from here
    // update(['charts']);
    notifyListeners();
    vocabularyFunction();
  }

  void vocabularyFunction() {
    List<double> values = [];
    // print('printing values here');
    // print(pictoStatisticsModel.pictoUsagePerGroup.toString());
    for (var element in pictoStatisticsModel.pictoUsagePerGroup) {
      values.add(element.percentage);
    }
    values.sort((a, b) => b.compareTo(a));
    //todo: add here the language too
    final language = 'es_AR';
    firstValueProgress = values[0];
    secondValueProgress = values[1];
    thirdValueProgress = values[2];
    fourthValueProgress = values[3];

    for (var element in pictoStatisticsModel.pictoUsagePerGroup) {
      if (element.percentage == firstValueProgress) {
        switch (language) {
          case "es_AR":
            firstValueText = element.name.es;
            break;
          case "en-US":
            firstValueText = element.name.en;
            break;
          case "fr-FR":
            firstValueText = element.name.fr;
            break;
          case "pt-BR":
            firstValueText = element.name.pt;
            break;
          default:
            firstValueText = element.name.es;
        }
      }
      if (element.percentage == secondValueProgress) {
        switch (language) {
          case "es_AR":
            secondValueText = element.name.es;
            break;
          case "en-US":
            secondValueText = element.name.en;
            break;
          case "fr-FR":
            secondValueText = element.name.fr;
            break;
          case "pt-BR":
            secondValueText = element.name.pt;
            break;
          default:
            secondValueText = element.name.es;
        }
      }
      if (element.percentage == thirdValueProgress) {
        switch (language) {
          case "es_AR":
            thirdValueText = element.name.es;
            break;
          case "en-US":
            thirdValueText = element.name.en;
            break;
          case "fr-FR":
            thirdValueText = element.name.fr;
            break;
          case "pt-BR":
            thirdValueText = element.name.pt;
            break;
          default:
            thirdValueText = element.name.es;
        }
      }
      if (element.percentage == fourthValueProgress) {
        switch (language) {
          case "es_AR":
            fourthValueText = element.name.es;
            break;
          case "en-US":
            fourthValueText = element.name.en;
            break;
          case "fr-FR":
            fourthValueText = element.name.fr;
            break;
          case "pt-BR":
            fourthValueText = element.name.pt;
            break;
          default:
            fourthValueText = element.name.es;
        }
      }
    }
    notifyListeners();
  }
}

final reportProvider = ChangeNotifierProvider<ReportProvider>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  final AuthRepository authService = GetIt.I.get<AuthRepository>();
  final ReportService reportService = GetIt.I.get<ReportService>();
  return ReportProvider(pictogramService, reportService, authService);
});

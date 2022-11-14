import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ottaa_project_flutter/app/data/models/frases_statistics_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/picto_statistics_model.dart';
import 'package:ottaa_project_flutter/app/data/models/report_chart_data_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';

class ReportController {
  //todo: need to get the values from other controllers
  final DataController _dataController = Get.find<DataController>();
  final HomeController _homeController = Get.find<HomeController>();
  late Timer _timer;
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
  late FrasesStatisticsModel frasesStatisticsModel;
  late List<String> randomPictos;
  late List<Pict> _pictos;
  double averagePictoFrase = 0.00;
  bool loadingMostUsedSentences = false;
  int frases7Days = 0;
  List<ChartModel> chartModel = [];
  late double scoreForProfile;
  double scoreProfile = 0.00;

  @override
  void onClose() {
    //todo: close the timer for the bottom widget carousel
    if (_timer.isActive) {
      _timer.cancel();
    }
    // super.onClose();
  }

  @override
  void onInit() async {
    //todo: fetching the required things
    _pictos = _homeController.picts;
    photoUrl = await _dataController.fetchUserPhotoUrl();
    await fetchPictoStatisticsData();
    await fetchMostUsedSentences();
    calculateScoreForProfile();
    // super.onInit();
  }

  Future<void> fetchPictoStatisticsData() async {
    final uid = _dataController.fetchCurrentUserUID();
    final uri = Uri.parse(
      'https://us-central1-ottaaproject-flutter.cloudfunctions.net/onReqFunc',
    );
    final body = {
      'UserID': uid,
      'Language': _homeController.language,
    };
    final res = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );
    print(res.body);
    pictoStatisticsModel = PictoStatisticsModel.fromJson(
      jsonDecode(res.body),
    );
    await makeMostUsedSentencesList();
  }

  Future<void> fetchMostUsedSentences() async {
    final uid = _dataController.fetchCurrentUserUID();
    final uri = Uri.parse(
        'https://us-central1-ottaaproject-flutter.cloudfunctions.net/readFile');
    final body = {
      'UserID': uid,
      'Language': _homeController.language,
    };
    final res = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );
    print(res.body);
    frasesStatisticsModel =
        FrasesStatisticsModel.fromJson(jsonDecode(res.body));
    frases7Days = frasesStatisticsModel.frases7Days;
    averagePictoFrase = frasesStatisticsModel.averagePictoFrase;
  }

  Future<void> makeMostUsedSentencesList() async {
    /// creating a list to add all of the ids
    List<List<int>> pictosIds = [];
    for (var element in pictoStatisticsModel.mostUsedSentences) {
      List<int> res = [];
      for (var element in element.pictoComponentes) {
        res.add(element.id);
        print(element.id);
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
            final val = element.imagen.pictoEditado ?? element.imagen.picto;
            res.add(val);
          }
        }
      }
      selectedPictosUrl.add(res);
    }
    mostUsedSentences = selectedPictosUrl;
    loadingMostUsedSentences = true;
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
    });
  }

  void calculateScoreForProfile() {
    ///last7DaysUsage = number of days the user used the app in the last 7 days.
    /// sentences7days = sentences created in the last 7 days.
    /// averagePictoFrase = average pictograms per sentence.
    /// usedGroups = number of different used groups.
    int usedGrupos = 0;
    frasesStatisticsModel.frecLast7Days.forEach((key, value) {
      print('here is the values from the map');
      final date = DateTime.fromMillisecondsSinceEpoch(
        int.parse(key),
      );
      final month = DateFormat.MMMM().format(date);
      print('${date.day} $month ${date.year}');
      chartModel.add(
        ChartModel(year: int.parse(key), count: value),
      );
      print('$key : $value');
    });
    print(chartModel.length);
    print(chartModel.last.year);
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
    score = (last7DaysUsage * a) +
        (frasesStatisticsModel.frases7Days * b) +
        (averagePictoFrase * c) +
        (usedGrupos * d);
    scoreProfile = score;
    String val = score.toString();
    val = val.substring(1);
    scorePercentageScore = double.parse(val) / 10;
    print(score);
    // return (int)(score / 1000);
    chartShow = true;
    //todo: update charts from here
    // update(['charts']);
    vocabularyFunction();
  }

  void vocabularyFunction() {
    List<double> values = [];
    print('printing values here');
    print(pictoStatisticsModel.pictoUsagePerGroup.toString());
    for (var element in pictoStatisticsModel.pictoUsagePerGroup) {
      values.add(element.percentage);
    }
    values.sort((a, b) => b.compareTo(a));
    final language = _homeController.language;
    firstValueProgress = values[0];
    secondValueProgress = values[1];
    thirdValueProgress = values[2];
    fourthValueProgress = values[3];

    for (var element in pictoStatisticsModel.pictoUsagePerGroup) {
      if (element.percentage == firstValueProgress) {
        switch (language) {
          case "es-AR":
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
          case "es-AR":
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
          case "es-AR":
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
          case "es-AR":
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
  }
}

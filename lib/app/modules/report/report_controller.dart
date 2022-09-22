import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ottaa_project_flutter/app/data/models/frases_statistics_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/picto_statistics_model.dart';
import 'package:ottaa_project_flutter/app/data/models/report_chart_data_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';

class ReportController extends GetxController {
  final DataController _dataController = Get.find<DataController>();
  final HomeController _homeController = Get.find<HomeController>();
  PageController pageController = PageController(
    initialPage: 0,
  );
  late Timer _timer;
  int currentPage = 0;
  RxString photoUrl = ''.obs;
  RxDouble scorePercentageScore = 0.00.obs;
  RxDouble firstValueProgress = 0.00.obs;
  RxDouble secondValueProgress = 0.00.obs;
  RxDouble thirdValueProgress = 0.00.obs;
  RxDouble fourthValueProgress = 0.00.obs;
  RxString firstValueText = 'first'.obs;
  RxString secondValueText = 'second'.obs;
  RxString thirdValueText = 'third'.obs;
  RxString fourthValueText = 'fourth'.obs;
  List<List<String>> mostUsedSentences = [];
  late PictoStatisticsModel pictoStatisticsModel;
  late FrasesStatisticsModel frasesStatisticsModel;
  late List<String> randomPictos;
  late List<Pict> _pictos;
  RxDouble averagePictoFrase = 0.00.obs;
  RxBool loadingMostUsedSentences = false.obs;
  RxInt frases7Days = 0.obs;
  List<ChartModel> chartModel = [];
  late double scoreForProfile;
  RxDouble scoreProfile = 0.00.obs;

  @override
  void onClose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() async {
    _pictos = _homeController.picts;
    photoUrl.value = await _dataController.fetchUserPhotoUrl();
    await fetchPictoStatisticsData();
    await fetchMostUsedSentences();
    calculateScoreForProfile();
    super.onInit();
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
    pictoStatisticsModel = PictoStatisticsModel.fromJson(jsonDecode(res.body));
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
    frases7Days.value = frasesStatisticsModel.frases7Days;
    averagePictoFrase.value = frasesStatisticsModel.averagePictoFrase;
  }

  Future<void> makeMostUsedSentencesList() async {
    /// creating a list to add all of the ids
    List<List<int>> pictosIds = [];
    pictoStatisticsModel.mostUsedSentences.forEach((element) {
      List<int> res = [];
      element.pictoComponentes.forEach((element) {
        res.add(element.id);
        print(element.id);
      });
      pictosIds.add(res);
    });

    /// getting the strings for the selected ids from the data
    List<List<String>> selectedPictosUrl = [];
    pictosIds.forEach((element) {
      List<String> res = [];
      element.forEach((id) {
        _pictos.forEach((element) {
          if (element.id == id) {
            final val = element.imagen.pictoEditado == null
                ? element.imagen.picto
                : element.imagen.pictoEditado;
            res.add(val!);
          }
        });
      });
      selectedPictosUrl.add(res);
    });
    mostUsedSentences = selectedPictosUrl;
    loadingMostUsedSentences.value = true;
    initializePageViewer();
  }

  void initializePageViewer() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 350),
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
    pictoStatisticsModel.pictoUsagePerGroup.forEach((element) {
      if (element.percentage > 0.0) {
        usedGrupos++;
      }
    });
    int a = 500, b = 3, c = 500, d = 44, last7DaysUsage = 0;
    frasesStatisticsModel.frecLast7Days.forEach((key, value) {
      last7DaysUsage = last7DaysUsage + value;
    });
    double score = 0;
    score = (last7DaysUsage * a) +
        (frasesStatisticsModel.frases7Days * b) +
        (averagePictoFrase.value * c) +
        (usedGrupos * d);
    scoreProfile.value = score;
    String val = score.toString();
    val = val.substring(1);
    scorePercentageScore.value = double.parse(val) / 10;
    print(score);
    // return (int)(score / 1000);
    vocabularyFunction();
    update(['charts']);
  }

  void vocabularyFunction() {
    List<double> values = [];
    pictoStatisticsModel.pictoUsagePerGroup.forEach((element) {
      values.add(element.percentage);
    });
    values.sort((a, b) => b.compareTo(a));
    final language = _homeController.language;
    firstValueProgress.value = values[0];
    secondValueProgress.value = values[1];
    thirdValueProgress.value = values[2];
    fourthValueProgress.value = values[3];
    pictoStatisticsModel.pictoUsagePerGroup.forEach((element) {
      if (element.percentage == firstValueProgress.value) {
        firstValueText.value =
            language == 'en' ? element.name.en : element.name.es;
      }
      if (element.percentage == secondValueProgress.value) {
        secondValueText.value =
            language == 'en' ? element.name.en : element.name.es;
      }
      if (element.percentage == thirdValueProgress.value) {
        thirdValueText.value =
            language == 'en' ? element.name.en : element.name.es;
      }
      if (element.percentage == fourthValueProgress.value) {
        fourthValueText.value =
            language == 'en' ? element.name.en : element.name.es;
      }
    });
  }
}

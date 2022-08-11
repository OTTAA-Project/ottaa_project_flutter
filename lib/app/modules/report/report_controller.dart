import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/frases_statistics_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/picto_statistics_model.dart';
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
  late double scoreForProfile;

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() async {
    _pictos = _homeController.picts;
    randomPictos = [];
    for (int i = 0; i <= 4; i++) {
      randomPictos.add(_pictos[
              Random(DateTime.now().millisecondsSinceEpoch + i).nextInt(200)]
          .imagen
          .picto);
      print(randomPictos[i]);
    }
    photoUrl.value = await _dataController.fetchUserPhotoUrl();
    await fetchPictoStatisticsData();
    await fetchMostUsedSentences();
    super.onInit();
  }

  Future<void> fetchPictoStatisticsData() async {
    final uid = _dataController.fetchCurrentUserUID();
    final uri = Uri.parse(
      'https://us-central1-ottaaproject-flutter.cloudfunctions.net/onReqFunc',
    );
    final body = {'UserID': uid};
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
    final body = {'UserID': uid};
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

    // int a = 500,
    //     b = 3,
    //     c = 500,
    //     d = 44,
    //     level = 0,
    //     last7DaysUsage = 0,
    //     usedGroups = 0;
    //
    // double score = 0;
    //
    // score = last7DaysUsage * a +
    //     frases7days * b +
    //     averagePictoFrase.value * c +
    //     usedGroups * d;
    //
    // return (int)(score / 1000);
  }
}

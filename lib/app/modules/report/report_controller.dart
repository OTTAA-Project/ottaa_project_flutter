import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/frases_statistics_model.dart';
import 'package:ottaa_project_flutter/app/data/models/picto_statistics_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';

class ReportController extends GetxController {
  final DataController _dataController = Get.find<DataController>();
  RxString photoUrl = ''.obs;
  RxDouble scorePercentageScore = 0.00.obs;
  RxDouble firstValueProgress = 0.00.obs;
  RxDouble secondValueProgress = 0.00.obs;
  RxDouble thirdValueProgress = 0.00.obs;
  RxString firstValueText = 'first'.obs;
  RxString secondValueText = 'second'.obs;
  RxString thirdValueText = 'third'.obs;
  final HomeController homeController = Get.find<HomeController>();
  late List<String> randomPictos;
  late PictoStatisticsModel pictoStatisticsModel;
  late FrasesStatisticsModel frasesStatisticsModel;
  RxDouble averagePictoFrase = 0.00.obs;
  RxInt frases7Days = 0.obs;
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() async {
    randomPictos = [];
    for (int i = 0; i <= 4; i++) {
      randomPictos.add(homeController
          .picts[Random(DateTime.now().millisecondsSinceEpoch + i).nextInt(200)]
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
    final uri = Uri.parse(
      'https://us-central1-ottaaproject-flutter.cloudfunctions.net/onReqFunc',
    );
    final body = {'UserID': 'KikJcMSzLcbEc5J5ya0ZFNrSwwv1'};
    final res = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );
    print(res.body);
    pictoStatisticsModel = PictoStatisticsModel.fromJson(jsonDecode(res.body));
  }

  Future<void> fetchMostUsedSentences() async {
    final uri = Uri.parse(
        'https://us-central1-ottaaproject-flutter.cloudfunctions.net/readFile');
    final body = {'UserID': 'KikJcMSzLcbEc5J5ya0ZFNrSwwv1'};
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
}

import 'package:ottaa_project_flutter/core/models/pictogram_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ottaa_project_flutter/core/models/report_chart_data_model.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';

class ReportProvider extends ChangeNotifier{

  final PictogramsRepository _pictogramsService;


  ReportProvider(this._pictogramsService,);

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

}


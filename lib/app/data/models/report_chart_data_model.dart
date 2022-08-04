import 'package:charts_flutter/flutter.dart' as charts;

class DeveloperSeries {
  final int year;
  final int developers;
  final charts.Color barColor;

  DeveloperSeries(
      {required this.year, required this.developers, required this.barColor,});
}

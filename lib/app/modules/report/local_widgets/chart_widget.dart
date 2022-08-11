import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ottaa_project_flutter/app/data/models/report_chart_data_model.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class ChartWidget extends StatelessWidget {
  ChartWidget({Key? key}) : super(key: key);
  final List<DeveloperSeries> data = [
    DeveloperSeries(
      year: 2016,
      developers: 0,
      barColor: charts.ColorUtil.fromDartColor(kOTTAAOrangeNew),
    ),
    DeveloperSeries(
      year: 2017,
      developers: 40000,
      barColor: charts.ColorUtil.fromDartColor(kOTTAAOrangeNew),
    ),
    DeveloperSeries(
      year: 2018,
      developers: 5000,
      barColor: charts.ColorUtil.fromDartColor(kOTTAAOrangeNew),
    ),
    DeveloperSeries(
      year: 2019,
      developers: 40000,
      barColor: charts.ColorUtil.fromDartColor(kOTTAAOrangeNew),
    ),
    DeveloperSeries(
      year: 2020,
      developers: 35000,
      barColor: charts.ColorUtil.fromDartColor(kOTTAAOrangeNew),
    ),
    DeveloperSeries(
      year: 2020,
      developers: 45000,
      barColor: charts.ColorUtil.fromDartColor(kOTTAAOrangeNew),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    List<charts.Series<DeveloperSeries, num>> series = [
      charts.Series(
          id: "developers",
          data: data,
          strokeWidthPxFn: (DeveloperSeries series, _) => 10,
          domainFn: (DeveloperSeries series, _) => series.year,
          measureFn: (DeveloperSeries series, _) => series.developers,
          colorFn: (DeveloperSeries series, _) => series.barColor)
    ];
    return Container(
      padding: const EdgeInsets.all(10),
      height: verticalSize * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          verticalSize * 0.02,
        ),
      ),
      child: charts.LineChart(
        series,
        domainAxis: const charts.NumericAxisSpec(
          tickProviderSpec:
              charts.BasicNumericTickProviderSpec(zeroBound: false),
          viewport: charts.NumericExtents(2000.0, 2022.0),
        ),
        animate: true,
      ),
    );
  }
}

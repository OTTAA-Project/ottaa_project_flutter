import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ottaa_project_flutter/app/data/models/report_chart_data_model.dart';
import 'package:ottaa_project_flutter/app/modules/report/report_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as ch;

class ChartWidget extends StatelessWidget {
  ChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    return GetBuilder<ReportController>(
        id: 'charts',
        builder: (controller) => Container(
              padding: const EdgeInsets.all(10),
              height: verticalSize * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  verticalSize * 0.02,
                ),
              ),
              child: controller.chartShow.value
                  ? SfCartesianChart(
                      series: <SplineSeries>[
                        SplineSeries<ChartModel, int>(
                          color: kOTTAAOrangeNew,
                          splineType: ch.SplineType.natural,
                          width: 6,
                          dataSource: controller.chartModel,
                          xValueMapper: (ChartModel developerSeries, _) {
                            // return '12';
                            final date = DateTime.fromMillisecondsSinceEpoch(
                                developerSeries.year);
                            // print(_);
                            return date.day;
                          },
                          yValueMapper: (ChartModel developerSeries, _) =>
                              developerSeries.count,
                        ),
                      ],
                      primaryXAxis: ch.NumericAxis(
                        labelFormat:
                            '{value} ${DateFormat.MMMM().format(DateTime.now()).toString().substring(0, 3)} ${DateTime.now().year}',
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        // decimalPlaces: 0,
                        // desiredIntervals: 6,
                        interval: 1,
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: kOTTAAOrangeNew,
                      ),
                    ),
            ));
  }
}

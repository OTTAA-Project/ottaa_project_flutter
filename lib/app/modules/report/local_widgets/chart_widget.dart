import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ottaa_project_flutter/app/data/models/report_chart_data_model.dart';
import 'package:ottaa_project_flutter/app/modules/report/report_controller.dart';
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
              child: SfCartesianChart(
                series: <ChartSeries>[
                  LineSeries<ChartModel, int>(
                    dataSource: controller.chartModel,
                    xValueMapper: (ChartModel developerSeries, _) {
                      // return '12';
                      // final date = DateTime.fromMillisecondsSinceEpoch(
                      //     developerSeries.year);
                      // print(_);
                      return developerSeries.year.toInt();
                    },
                    yValueMapper: (ChartModel developerSeries, _) =>
                        developerSeries.count,
                  ),
                ],
                primaryXAxis: ch.NumericAxis(
                  labelFormat:
                      '{value} ${DateFormat.MMMM().format(DateTime.now())} ${DateTime.now().year}',
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                ),
              ),
            ));
  }
}

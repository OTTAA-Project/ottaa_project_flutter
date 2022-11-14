import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ottaa_project_flutter/core/models/report_chart_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as ch;

import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    //todo: we need to update the chart for the values
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
      //todo: add a loading here
      child: controller.chartShow.value
          ? SfCartesianChart(
              series: <SplineSeries>[
                SplineSeries<ChartModel, int>(
                  color: kOTTAAOrangeNew,
                  splineType: ch.SplineType.natural,
                  width: 6,
                  //todo: get data here from teh providers
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
          : const Center(
              child: CircularProgressIndicator(
                color: kOTTAAOrangeNew,
              ),
            ),
    );
  }
}

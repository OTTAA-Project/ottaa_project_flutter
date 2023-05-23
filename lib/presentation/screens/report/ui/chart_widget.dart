import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ottaa_project_flutter/application/providers/report_provider.dart';
import 'package:ottaa_project_flutter/core/models/chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as ch;

import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class ChartWidget extends ConsumerWidget {
  const ChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verticalSize = MediaQuery.of(context).size.height;
    final provider = ref.watch(reportProvider);
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
      child: provider.chartShow
          ? SfCartesianChart(
              series: <SplineSeries>[
                SplineSeries<ChartModel, int>(
                  color: kOTTAAOrangeNew,
                  splineType: ch.SplineType.natural,
                  width: 6,
                  //todo: get data here from teh providers
                  dataSource: provider.chartModel,
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

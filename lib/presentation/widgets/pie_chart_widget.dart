import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartSample extends StatelessWidget {
  PieChartSample({
    super.key,
    required this.complatedLength,
    required this.pendingLength,
  });
  final double complatedLength;
  final double pendingLength;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.center,
        ),
        Center(
          child: SfCircularChart(
            palette: <Color>[
              Colors.red,
              Color.fromARGB(255, 44, 151, 209),
            ],
            series: <CircularSeries>[
              DoughnutSeries<ProgressTask, String>(
                dataSource: <ProgressTask>[
                  ProgressTask('Pending', pendingLength),
                  ProgressTask('Complated', complatedLength),
                ],
                xValueMapper: (ProgressTask task, _) => task.title,
                yValueMapper: (ProgressTask task, _) => task.numOfTask,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                legendIconType: LegendIconType.circle,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ProgressTask {
  ProgressTask(this.title, this.numOfTask);
  final String title;
  final double numOfTask;
}

import 'package:expense_tracker/bar%20graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final double? maxY;
  final double monAmount;
  final double tuesAmount;
  final double wedAmount;
  final double thursAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  const BarGraph({
    super.key,
    required this.maxY,
    required this.monAmount,
    required this.tuesAmount,
    required this.wedAmount,
    required this.thursAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  @override
  Widget build(BuildContext context) {
    //initialize
    BarData myBarData = BarData(
      monAmount: monAmount,
      tuesAmount: tuesAmount,
      wedAmount: wedAmount,
      thursAmount: thursAmount,
      friAmount: friAmount,
      satAmount: satAmount,
      sunAmount: sunAmount,
    );
    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        minY: 0,
        maxY: maxY,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          show: true,
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    //color: const Color.fromARGB(255, 89, 168, 126),
                    color: const Color.fromRGBO(82, 121, 111, 1),
                    width: 25,
                    borderRadius: BorderRadius.circular(5),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxY,
                      color: const Color.fromARGB(41, 18, 77, 23),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 13.5,
    color: Colors.grey,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        "M",
        style: style,
      );
      break;
    case 1:
      text = const Text(
        "T",
        style: style,
      );
      break;
    case 2:
      text = const Text(
        "W",
        style: style,
      );
      break;
    case 3:
      text = const Text(
        "Th",
        style: style,
      );
      break;
    case 4:
      text = const Text(
        "F",
        style: style,
      );
      break;
    case 5:
      text = const Text(
        "Sat",
        style: style,
      );
      break;
    case 6:
      text = const Text(
        "S",
        style: style,
      );
      break;
    default:
      text = const Text(
        "",
        style: style,
      );
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

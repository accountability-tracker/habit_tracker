import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:habit_tracker/theme.dart';

class HistoryLineChart extends StatefulWidget {
  const HistoryLineChart({
    super.key,
    required this.habitDates,
    required this.habit,
  });

  final dynamic habitDates;
  final dynamic habit;

  @override
  State<HistoryLineChart> createState() => _HistoryLineChart();
}

class _HistoryLineChart extends State<HistoryLineChart> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    final List<FlSpot> data = List.generate(widget.habitDates.length, (index) {
      var x = widget.habitDates[index] != null ? widget.habitDates[index]["value"].toDouble() : 0.0;

      return FlSpot(index.toDouble(), index.toDouble() * x.toDouble());
    });

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 260.0,
      child: LineChart(
        swapAnimationDuration: const Duration(milliseconds: 150),
        swapAnimationCurve: Curves.linear,

        LineChartData(
            minX: 0,
          lineBarsData: [
            LineChartBarData(
              spots: data,
              isCurved: true,
              barWidth: 2,
              isStrokeCapRound: true,
              preventCurveOverShooting: true,
              // curveSmoothness: 0.2,
              color: Color(widget.habit.getColor()),
            ),
          ],
          titlesData: FlTitlesData(
            // show: false,

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  var style = TextStyle(
                    color: customColors.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  Widget text;

                  // print(meta.sideTitles.toString());

                  // var x = widget.habitDates[value.toInt()]["date"].split("-");
                  String range = widget.habitDates[value.toInt()]["date"];

                  text = SizedBox(
                    height: 32.0,
                    child: Row(
                      children: <Widget>[Text(range, style: style)],
                    ),
                  );

                  // switch (value.toInt()) {
                  //   case 0:
                  //   text = const Text('Test', style: style);
                  //   break;
                  //   case 1:
                  //   text = const Text('T', style: style);
                  //   break;
                  //   case 2:
                  //   text = const Text('W', style: style);
                  //   break;
                  //   default:
                  //   text = const Text('', style: style);
                  //   break;
                  // }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 16,
                    child: text,
                  );
                },
                reservedSize: 38,
              ),
              // axisNameWidget: Text(x),
            ),

            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 32.0,
                showTitles: true,
                // interval: largest_value / 9
              ),
            ),

            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),

            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),

          gridData: FlGridData(
            drawVerticalLine: false,
            drawHorizontalLine: true,
          ),

          borderData: FlBorderData(
            border: Border.all(
                color: const Color.fromRGBO(41, 41, 41, 1.0), width: 1.0, style: BorderStyle.solid),
          ),
        ),
      ),
    );
  }
}

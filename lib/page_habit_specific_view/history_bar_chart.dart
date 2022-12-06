import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryBarChart extends StatefulWidget {
  const HistoryBarChart({
      super.key,
      required this.habitDates,
  });

  final dynamic habitDates;

  @override
  _HistoryBarChart createState() => _HistoryBarChart();
}

class _HistoryBarChart extends State<HistoryBarChart> {

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;

    // print(meta.sideTitles.toString());

    switch (value.toInt()) {
      case 0:
      text = const Text('Test', style: style);
      break;
      case 1:
      text = const Text('T', style: style);
      break;
      case 2:
      text = const Text('W', style: style);
      break;
      default:
      text = const Text('', style: style);
      break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  @override
  Widget build(BuildContext context) {

    // print(widget.habit_dates);

    return Container(
        width: MediaQuery.of(context).size.width,
        height: 260.0,
        child: BarChart(
          BarChartData(
            barGroups: [
              BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: widget.habitDates[0]["value"].toDouble())]),
              BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: widget.habitDates[1]["value"].toDouble())]),
              BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: widget.habitDates[2]["value"].toDouble())]),
              BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: widget.habitDates[3]["value"].toDouble())]),
              BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: widget.habitDates[4]["value"].toDouble())]),
            ],

            titlesData: FlTitlesData(
              // show: false,

              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,

                  getTitlesWidget: (double value, TitleMeta meta) {
                    const style = TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    );
                    Widget text;

                    // print(meta.sideTitles.toString());

                    var x = widget.habitDates[value.toInt()]["date"].split("-");
                    String range = widget.habitDates[value.toInt()]["date"];

                    text = Container(
                      height: 32.0,
                      child: Row(
                        children: <Widget>[
                          Text(
                            range,
                            style: style
                          )
                        ],
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
                  showTitles: false,
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
                color: const Color.fromRGBO(41, 41, 41, 1.0),
                width: 1.0,
                style: BorderStyle.solid
              ),
            ),

          ),


          // swapAnimationDuration: Duration(milliseconds: 150), // Optional
          // swapAnimationCurve: Curves.linear, // Optional
        ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryBarChart extends StatefulWidget {
  const HistoryBarChart({
      super.key,
      required this.habit_dates,
  });

  final dynamic habit_dates;

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
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 260.0,
        child: BarChart(
          BarChartData(
            barGroups: [
              BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: widget.habit_dates[0]["object"] != null ? widget.habit_dates[0]["object"].getValue().toDouble() : 0 )]),
              BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: widget.habit_dates[1]["object"] != null ? widget.habit_dates[1]["object"].getValue().toDouble() : 0 )]),
              BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: widget.habit_dates[2]["object"] != null ? widget.habit_dates[2]["object"].getValue().toDouble() : 0 )]),
              BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: widget.habit_dates[3]["object"] != null ? widget.habit_dates[3]["object"].getValue().toDouble() : 0 )]),
              BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: widget.habit_dates[4]["object"] != null ? widget.habit_dates[4]["object"].getValue().toDouble() : 0 )]),
              BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: widget.habit_dates[5]["object"] != null ? widget.habit_dates[5]["object"].getValue().toDouble() : 0 )]),
              BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: widget.habit_dates[6]["object"] != null ? widget.habit_dates[6]["object"].getValue().toDouble() : 0 )]),
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

                    var x = widget.habit_dates[value.toInt()]["date"].split("-");

                    text = Container(
                      height: 32.0,
                      child: Row(
                        children: <Widget>[
                          Text(
                            x[1] + "-",
                            style: style
                          ),

                          Text(
                            x[2],
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
                color: Color.fromRGBO(41, 41, 41, 1.0),
                width: 1.0,
                style: BorderStyle.solid
              ),
            ),

          ),


          // swapAnimationDuration: Duration(milliseconds: 150), // Optional
          // swapAnimationCurve: Curves.linear, // Optional
        ),
      ),
    );
  }
}

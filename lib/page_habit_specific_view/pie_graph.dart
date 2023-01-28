//import 'package:pie_graph_test/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit_date.dart';
import 'package:intl/intl.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}

class PieGraph extends ConsumerStatefulWidget {
  const PieGraph({
    super.key,
    this.habitList,
    required this.isarService,
  });

  final habitList;
  final IsarService isarService;

  @override
  ConsumerState<PieGraph> createState() => _PieGraph();
}

class _PieGraph extends ConsumerState<PieGraph> {
  int touchedIndex = -1;
  List<double> habitDateValues = [];

  late Future<List<HabitDate>>? fhabitDates;

  @override
  void initState() {
    super.initState();
    for (var habit in widget.habitList) {
      habitDateValues.add(0.0);
    }

    setState(() => {
          fhabitDates =
              widget.isarService.getHabitsDateCurrentMonth(DateFormat('y-M').format(DateTime.now()))
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: FutureBuilder<List<HabitDate>>(
            future: fhabitDates,
            builder: (context, AsyncSnapshot<List<HabitDate>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                for (var habitDate in snapshot.data!) {
                  for (int i = 0; i < widget.habitList.length; i++) {
                    if (habitDate.habitId == widget.habitList[i].id && habitDate.getValue() > 0) {
                      habitDateValues[i]++;
                      break;
                    }
                  }
                }
                return Row(
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    Column(
                      children: <Container>[
                        Container(
                          constraints: BoxConstraints(
                              minHeight: 175,
                              minWidth: 175,
                              maxHeight: MediaQuery.of(context).size.width * 0.55,
                              maxWidth: MediaQuery.of(context).size.width * 0.55),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: PieChart(
                            PieChartData(
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 2,
                              centerSpaceRadius: 20,
                              sections: showingSections(),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: showIndicators()),
                  ],
                );
              }
              return const Text(
                "Loading indacator...",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.red,
                ),
              );
            }));
  }

  List<PieChartSectionData> showingSections() {
    double totalVal = 0.0;
    for (var i in habitDateValues) {
      totalVal += i;
    }

    return List.generate(habitDateValues.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 50.0 : 15.0;
      //final radius = isTouched ? 120.0 : radius;
      final radius = MediaQuery.of(context).size.width * 0.15;
      double percent = (habitDateValues[i] / totalVal) * 100;
      percent = double.parse((percent).toStringAsFixed(2));
      String sectionTitle = "$percent%";
      return PieChartSectionData(
        color: Color(widget.habitList[i].getColor()),
        value: percent,
        title: sectionTitle,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );
    });
  }

  List<Widget> showIndicators() {
    return List.generate(habitDateValues.length, (i) {
      return Column(children: <Widget>[
        Indicator(
          color: Color(widget.habitList[i].getColor()),
          text: widget.habitList[i].getTitle(),
          isSquare: true,
        ),
        const SizedBox(
          height: 18,
        )
      ]);
    });
  }
}

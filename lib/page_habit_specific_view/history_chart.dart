import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit_date.dart';

import 'package:habit_tracker/page_habit_specific_view/history_bar_chart.dart';
import 'package:intl/intl.dart';

// import '../components/FlatDropdown.dart';

class HistoryChart extends ConsumerStatefulWidget {
  const HistoryChart({
      super.key,
      required this.isarService,
      required this.habit
  });

  final IsarService isarService;

  // TODO: eventually handle the other habit types besides yes or no
  final dynamic habit;

  @override
  _HistoryChart createState() => _HistoryChart();
}

class _HistoryChart extends ConsumerState<HistoryChart> {

  String periodSelected = "Week";

  var items = [
    'Week',
    'Month',
    'Quarter',
    'Year',
  ];
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(
        8.0, 12.0, 8.0, 12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.grey[800],
        // boxShadow: [
        //   BoxShadow(color: Colors.green, spreadRadius: 3),
        // ],
      ),

      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "History",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),

              Spacer(),

              Text(
                "Selector  -  ",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Column(
                children: [
                  DropdownButton(
                    // Initial Value
                    dropdownColor: Color.fromRGBO(41, 41, 41, 1.0),
                    value: periodSelected,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    style: const TextStyle(
                            fontSize: 20.0,
                          ),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        periodSelected = newValue!;
                      });
                    },
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: 16.0,),

          FutureBuilder<List<HabitDate>>(
            future: widget.isarService.getHabitsDateLastSelectedPeriod(widget.habit.id, periodSelected),

            builder: (BuildContext context, AsyncSnapshot<List<HabitDate>> snapshot) {
              switch(snapshot.connectionState) {
                case ConnectionState.done:
                var habitDates = snapshot.data;
                var d = DateTime.now();

                List<dynamic> xy = [];
                List<dynamic> periods = [];

                if (periodSelected == 'Week') {
                  DateTime start = DateTime(d.year, d.month, d.day).subtract(Duration(days: d.weekday));
                  DateTime end = start.add(Duration(days: 7));

                  periods = [
                    {'start': start.subtract(Duration(days: 28)), 'end': end.subtract(Duration(days: 28)), 'value' : 0},
                    {'start': start.subtract(Duration(days: 21)), 'end': end.subtract(Duration(days: 21)), 'value' : 0},
                    {'start': start.subtract(Duration(days: 14)), 'end': end.subtract(Duration(days: 14)), 'value' : 0},
                    {'start': start.subtract(Duration(days: 7)), 'end': end.subtract(Duration(days: 7)), 'value' : 0},
                    {'start': start, 'end': end, 'value' : 0},
                  ];
                }
                else if (periodSelected == 'Month') {
                  periods = [
                    {'start': DateTime(d.year, d.month-4, 1), 'end': DateTime(d.year, d.month-3, 1), 'value' : 0, 'dateString': DateFormat('yMMMM').format(DateTime(d.year, d.month-4, 1))},
                    {'start': DateTime(d.year, d.month-3, 1), 'end': DateTime(d.year, d.month-2, 1), 'value' : 0, 'dateString': DateFormat('yMMMM').format(DateTime(d.year, d.month-3, 1))},
                    {'start': DateTime(d.year, d.month-2, 1), 'end': DateTime(d.year, d.month-1, 1), 'value' : 0, 'dateString': DateFormat('yMMMM').format(DateTime(d.year, d.month-2, 1))},
                    {'start': DateTime(d.year, d.month-1, 1), 'end': DateTime(d.year, d.month, 1), 'value' : 0, 'dateString': DateFormat('yMMMM').format(DateTime(d.year, d.month-1, 1))},
                    {'start': DateTime(d.year, d.month, 1), 'end': DateTime(d.year, d.month+1, 1), 'value' : 0, 'dateString': DateFormat('yMMMM').format(d)},
                  ];
                }
                else if (periodSelected == 'Quarter') {
                  DateTime start = DateTime(d.year, 1, 1);
                  DateTime end = DateTime(d.year, 4, 1).subtract(Duration(days: 1));
                  // Find the current quarter.
                  int currentQuarter = 1;
                  for (currentQuarter=1; currentQuarter<4; currentQuarter++) {
                    if (d.isBefore(end) && d.isAfter(start)) {
                      //current quarter found
                      break;
                    }
                    start = DateTime(start.year, start.month+3, 1);
                    end = DateTime(end.year, start.month+3, 1).subtract(Duration(days: 1));
                  }

                  periods = [{'start': start, 'end': end, 'value' : 0, 'dateString': '${d.year} Q$currentQuarter'}];
                  for (var i=0; i<4; i++) {
                    currentQuarter = currentQuarter - 1;
                    if (currentQuarter == 0) {
                      currentQuarter = 4;
                    }
                    end = start.subtract(Duration(days: 1));
                    start = DateTime(start.year, start.month-3, 1);
                    periods.insert(0, {'start': start, 'end': end, 'value' : 0, 'dateString': '${start.year} Q$currentQuarter'});
                  }
                }
                else if (periodSelected == 'Year') {
                  periods = [
                    {'start': DateTime(d.year-4, 1, 1), 'end': DateTime(d.year-3, 1, 1), 'value' : 0, 'dateString': (d.year-4).toString()},
                    {'start': DateTime(d.year-3, 1, 1), 'end': DateTime(d.year-2, 1, 1), 'value' : 0, 'dateString': (d.year-3).toString()},
                    {'start': DateTime(d.year-2, 1, 1), 'end': DateTime(d.year-1, 1, 1), 'value' : 0, 'dateString': (d.year-2).toString()},
                    {'start': DateTime(d.year-1, 1, 1), 'end': DateTime(d.year, 1, 1), 'value' : 0, 'dateString': (d.year-1).toString()},
                    {'start': DateTime(d.year, 1, 1), 'end': DateTime(d.year+1, 1, 1), 'value' : 0, 'dateString': d.year.toString()},
                  ];
                }

                for(var v in habitDates!) {
                  var eventDate = v.getDate().split('-');
                  int year = int.parse(eventDate[0]);
                  int month = int.parse(eventDate[1]);
                  int day = int.parse(eventDate[2]);

                  for (var period in periods) {
                    if ((DateTime(year, month, day).isAfter(period['start']) || period['start'] == DateTime(year, month, day)) && DateTime(year, month, day).isBefore(period['end'])) {
                      period['value'] += v.getValue();
                    }
                  }
                }
                for (var period in periods) {
                  String dateString = DateFormat('M-dd').format(period['start']) + ' to ' + DateFormat('M-dd').format(period['end']);
                  if (periodSelected == 'Month') {
                    dateString = period['dateString'];
                  }
                  else if (periodSelected == 'Quarter') {
                    dateString = period['dateString'];
                  }
                  else if (periodSelected == 'Year') {
                    dateString = period['dateString'];
                  }
                  xy.add({
                    'date': dateString,
                    'value': period['value']
                  });
                }

                return HistoryBarChart(
                  habitDates: xy, // habit_dates
                );

                default:
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 260.0,
                    child: const Text("Loading"),
                  );
              }
            }
          ),

        ],
      ),
    );

  }
}
